use mlua::prelude::*;

use crate::api::plugin::{Channel, PluginCallback};

pub(crate) struct LuauServerUserData(pub(crate) PluginCallback);

impl LuaUserData for LuauServerUserData {

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("Process", |_, this, (event, force): (LuaTable, Option<bool>)| {
            let serialized_event = serde_json::to_string(&event).unwrap();
            let process_event = this.0.process_event.clone();
            let _ = process_event(serialized_event, force);
            Ok(())
        });
        methods.add_method("Send", |_, this, (event, target): (LuaTable, Option<Channel>)| {
            let serialized_event = serde_json::to_string(&event).unwrap();
            let send_event = this.0.send_event.clone();
            let _ = send_event(serialized_event, target);
            Ok(())
        });
    }
}
