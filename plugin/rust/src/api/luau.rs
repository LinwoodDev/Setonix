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
        let details = EventDetails::new(server_event, target, source, cancelled, None);
        let event : JsonObject = serde_json::from_str(&event).unwrap();
        let (event, lua_value) = {
            let engine = self.engine.lock().await;
            (
                engine.to_value(&event).unwrap(),
                engine.to_value(&details).unwrap(),
            )
        };
        {
            println!("Runniong event '{:?}' in Luau plugin", event.to_string());
            let engine = self.event_system.lock().await;
            engine
                .run_event_handler(&event_type, (event, &lua_value))
                .await
        };
        let updated: EventDetails = self.engine.lock().await.from_value(lua_value).unwrap();
        EventResult::build(updated, Some(details))
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
