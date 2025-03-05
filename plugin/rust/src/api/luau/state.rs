use futures::executor::block_on;
use mlua::prelude::*;
use serde_json::Value;
use strum::IntoEnumIterator;

use crate::api::plugin::{PluginCallback, StateFieldAccess};

pub(crate) struct LuauStateUserData(pub(crate) PluginCallback);

impl LuaUserData for LuauStateUserData {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        for field in StateFieldAccess::iter() {
            let name = field.to_string();
            fields.add_field_method_get(name.clone(), move |lua, this: &LuauStateUserData| {
                let callback = this.0.state_field_access.clone();
                let result = block_on(callback(field.clone()));
                let result = serde_json::from_str::<Value>(&result).unwrap();
                let serialized = lua.to_value(&result).unwrap();
                Ok(serialized)
            });
            fields.add_field_method_set(name, move |_, this: &mut LuauStateUserData, value: LuaValue| {
                let callback = this.0.state_field_change.clone();
                let value = serde_json::to_string(&value).unwrap();
                block_on(callback(field.clone(), value));
                Ok(())
            });
        }
    }
}
