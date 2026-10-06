use mlua::prelude::*;

use crate::api::plugin::{Channel, PluginCallback};

pub(crate) struct LuauServerUserData(pub(crate) PluginCallback);

impl LuaUserData for LuauServerUserData {
    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_async_method(
            "Process",
            async |_, this, (event, force): (LuaTable, Option<bool>)| {
                let serialized_event = serde_json::to_string(&event).unwrap();
                let process_event = this.0.process_event.clone();
                process_event(serialized_event, force)
                    .await
                    .map_err(LuaError::external)?;
                Ok(())
            },
        );
        methods.add_async_method(
            "Send",
            async |_, this, (event, target): (LuaTable, Option<Channel>)| {
                let serialized_event = serde_json::to_string(&event).unwrap();
                let send_event = this.0.send_event.clone();
                send_event(serialized_event, target)
                    .await
                    .map_err(LuaError::external)?;
                Ok(())
            },
        );
    }
}
