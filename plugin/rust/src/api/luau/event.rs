use std::{collections::HashMap, sync::{Arc}};

use flutter_rust_bridge::frb;
use mlua::prelude::*;
use tokio::sync::Mutex;

#[derive(Default)]
#[frb(ignore)]
pub(crate) struct LuauEventSystem {
    event_handlers: HashMap<String, Vec<(u64, LuaFunction)>>,
    next_id: u64,
}

impl LuauEventSystem {
    pub(crate) async fn run_event_handler(&self, event: &str, args: impl IntoLuaMulti + Clone) {
        if let Some(handlers) = self.event_handlers.get(event) {
            for (_, handler) in handlers {
                if let Err(err) = handler.call_async::<()>(args.clone()).await {
                    eprintln!("Failed to call handler for '{}': {}", event, err);
                }
            }
        }
    }
}

pub(crate) struct LuauEventSystemUserData(pub(crate) Arc<Mutex<LuauEventSystem>>);

impl LuaUserData for LuauEventSystemUserData {
    fn add_methods<M: mlua::UserDataMethods<Self>>(methods: &mut M) {
        methods.add_meta_method(LuaMetaMethod::Index, |lua, this, key: String| {
            let event_system = Arc::clone(&this.0);
            let event_name = key.clone();

            let tbl = lua.create_table()?;

            let connect_fn = {
                let event_system_shared = Arc::clone(&event_system);
                let event_name_shared = event_name.clone();
                lua.create_async_function(move |lua_ctx, (_, handler): (mlua::Value, LuaFunction)| {
                    let event_system = Arc::clone(&event_system_shared);
                    let event_name = event_name_shared.clone();
                    async move {
                        let mut system = event_system.lock().await;
                        let handler_id = system.next_id;
                        system.next_id += 1;
                        system
                            .event_handlers
                            .entry(event_name.clone())
                            .or_insert_with(Vec::new)
                            .push((handler_id, handler.clone()));

                        let connection = LuauEventConnection {
                            event_system: Arc::clone(&event_system),
                            event_name,
                            handler_id,
                        };
                        lua_ctx.create_userdata(connection)
                    }
                })?
            };
            tbl.set("Connect", connect_fn)?;

            Ok(tbl)
        });
    }
}

pub(crate) struct LuauEventConnection {
    event_system: Arc<Mutex<LuauEventSystem>>,
    event_name: String,
    handler_id: u64,
}

impl LuaUserData for LuauEventConnection {
    fn add_methods<M: mlua::UserDataMethods<Self>>(methods: &mut M) {
        methods.add_async_method("Disconnect", async |_, this, ()| {
            let mut system = this.event_system.lock().await;
            if let Some(handlers) = system.event_handlers.get_mut(&this.event_name) {
                handlers.retain(|(id, _)| *id != this.handler_id);
            }
            Ok(())
        });
    }
}
