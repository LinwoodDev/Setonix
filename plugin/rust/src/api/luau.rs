use event::*;
use tokio::sync::Mutex;
use std::sync::Arc;

use flutter_rust_bridge::frb;
use futures::executor::block_on;
use mlua::prelude::*;
use state::LuauStateUserData;

use crate::api::luau::server::LuauServerUserData;

use super::plugin::*;

pub mod event;
pub mod server;
pub mod state;

impl PluginCallback {
    fn construct_on_print(&self, engine: &Lua) -> LuaResult<LuaFunction> {
        let on_print = self.on_print.clone();
        engine.create_function(move |_, s: String| {
            block_on(on_print(s));
            Ok(())
        })
    }

    fn construct_globals(&self, engine: &Lua) -> LuaResult<()> {
        engine
            .globals()
            .set("print", self.construct_on_print(engine)?)?;
        Ok(())
    }
}

pub struct LuauPlugin {
    engine: Arc<Mutex<Lua>>,
    code: String,
    event_system: Arc<Mutex<LuauEventSystem>>,
}

#[derive(Clone)]
#[frb(ignore)]
struct LuaEventDetails(Arc<std::sync::Mutex<EventDetails>>);

impl LuaUserData for LuaEventDetails {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        fields.add_field_method_get("source", |_, this| {
            let guard = this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?;
            Ok(guard.source)
        });
        fields.add_field_method_get("target", |_, this| {
            let guard = this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?;
            Ok(guard.target)
        });
        fields.add_field_method_get("cancelled", |_, this| {
            let guard = this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?;
            Ok(guard.cancelled)
        });
        fields.add_field_method_get("server_event", |lua, this| {
            let guard = this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?;
            let value = lua.to_value(&guard.server_event).map_err(mlua::Error::external)?;
            Ok(value)
        });
        fields.add_field_method_set("cancelled", |_, this, val: bool| {
            let mut guard = this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?;
            guard.cancelled = val;
            Ok(())
        });
        fields.add_field_method_set("server_event", |lua, this, val: mlua::Value| {
            let mut guard = this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?;
            let value: serde_json::Value = lua.from_value(val).map_err(mlua::Error::external)?;
            guard.server_event = serde_json::from_value(value).map_err(mlua::Error::external)?;
            Ok(())
        });
    }
    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("ScheduleEvent", |lua, this, (event, channel): (mlua::Value, Option<Channel>)| {
            let event: serde_json::Value = lua.from_value(event)?;
            println!("Scheduling event from Lua: {:?}", event);
            let event = event.to_string();
            this.0.lock().map_err(|_| mlua::Error::RuntimeError("Lock poisoned".to_string()))?.schedule_event(event, channel);
            Ok(())
        });
    }
}

impl RustPlugin for LuauPlugin {
    async fn run_event(
        &self,
        event_type: String,
        event: String,
        server_event: String,
        source: Channel,
        cancelled: bool,
        target: Channel,
    ) -> EventResult {
        let server_event: JsonObject = serde_json::from_str(&server_event).unwrap();
        let old = EventDetails::new(server_event, target, source, cancelled, None);
        let details = LuaEventDetails(Arc::new(std::sync::Mutex::new(old.clone())));
        let event : JsonObject = serde_json::from_str(&event).unwrap();
        let (event, lua_value) = {
            let details = details.clone();
            let engine = self.engine.lock().await;
            (
                engine.to_value(&event).unwrap(),
                details.into_lua(&engine).unwrap(),
            )
        };
        {
            
            let engine = self.event_system.lock().await;
            engine
                .run_event_handler(&event_type, (event, lua_value))
                .await
        };
        let result = details.0.lock().unwrap().clone();
        EventResult::build(result, Some(old))
    }

    async fn run(&self) -> Result<(), anyhow::Error> {
        let chunk =  {
            let engine = self.engine.lock().await;
            engine.load(&self.code)
        };
        chunk.exec_async().await.map_err(anyhow::Error::from)
    }
}

impl LuauPlugin {
    #[frb(sync)]
    pub fn new(code: String, callback: PluginCallback) -> LuauPlugin {
        let engine = Lua::new();
        engine.sandbox(true).unwrap();
        callback.construct_globals(&engine).unwrap();
        let event_system = LuauEventSystem::default();
        let event_system = Arc::new(Mutex::new(event_system));
        engine
            .globals()
            .set("Events", LuauEventSystemUserData(Arc::clone(&event_system)))
            .unwrap();
        engine
            .globals()
            .set("State", LuauStateUserData(callback.clone()))
            .unwrap();
        engine
            .globals()
            .set("Server", LuauServerUserData(callback))
            .unwrap();

        let engine = Arc::new(Mutex::new(engine));
        Self {
            engine,
            code,
            event_system,
        }
    }
}
