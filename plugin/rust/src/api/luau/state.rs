use mlua::prelude::*;
use serde_json::Value;
use strum::IntoEnumIterator;

use crate::api::plugin::{PluginCallback, StateFieldAccess};

pub(crate) struct LuauStateUserData(pub(crate) PluginCallback);

fn parse_json_string(value: String) -> String {
    match serde_json::from_str::<String>(&value) {
        Ok(decoded) => decoded,
        Err(_) => value,
    }
}

impl LuaUserData for LuauStateUserData {
    fn add_fields<F: LuaUserDataFields<Self>>(fields: &mut F) {
        for field in StateFieldAccess::iter() {
            let name = field.to_string();
            fields.add_field_method_get(name.clone(), move |lua, this: &LuauStateUserData| {
                let result = this.0.state_field_access(field);
                let result = serde_json::from_str::<Value>(&result).unwrap();
                let serialized = lua
                    .to_value_with(&result, super::LUA_SERIALIZE_OPTIONS)
                    .unwrap();
                Ok(serialized)
            });
        }
        fields.add_field_method_get("PluginId", move |lua, this: &LuauStateUserData| {
            let namespace =
                parse_json_string(this.0.state_field_access(StateFieldAccess::Namespace));
            let game = parse_json_string(this.0.state_field_access(StateFieldAccess::Game));
            let plugin_id = format!("{}:{}", namespace, game);
            let serialized = lua
                .to_value_with(&plugin_id, super::LUA_SERIALIZE_OPTIONS)
                .unwrap();
            Ok(serialized)
        });
    }

    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method(
            "GetTable",
            |lua, this: &LuauStateUserData, table_name: Option<String>| {
                let result = this.0.table_access(table_name);
                let result = serde_json::from_str::<Value>(&result).unwrap();
                let serialized = lua
                    .to_value_with(&result, super::LUA_SERIALIZE_OPTIONS)
                    .unwrap();
                Ok(serialized)
            },
        );
    }
}
