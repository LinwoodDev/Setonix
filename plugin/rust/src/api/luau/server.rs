use mlua::prelude::*;

use crate::api::plugin::{Channel, PluginCallback};

pub(crate) struct LuauServerUserData(pub(crate) PluginCallback);

impl LuaUserData for LuauServerUserData {

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_async_method("Process", async |_, this, (event, force): (LuaTable, Option<bool>)| {
            let event_name = event.get::<String>("type");
            println!("Processing event from Luau plugin: {:?}", event_name);
            let serialized_event = serde_json::to_string(&event).unwrap();
            let process_event = this.0.process_event.clone();
            flutter_rust_bridge::spawn( async move {
                if let Err(err) = process_event(serialized_event, force).await {
                    eprintln!("Error processing event: {:?}", err);
                }

            }).await.map_err(anyhow::Error::from)?;
            Ok(())
        });
        methods.add_async_method("Send", async |_, this, (event, target): (LuaTable, Option<Channel>)| {
            let serialized_event = serde_json::to_string(&event).unwrap();
            let send_event = this.0.send_event.clone();
            println!("Sending event from Luau plugin to target {:?}: {:?}", target, serialized_event);
            flutter_rust_bridge::spawn( async move {
                if let Err(err) = send_event(serialized_event, target).await {
                    eprintln!("Error processing event: {:?}", err);
                }

            }).await.map_err(anyhow::Error::from)?;
            Ok(())
        });
    }
}
