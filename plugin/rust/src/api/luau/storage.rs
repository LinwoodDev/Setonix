use futures::executor::block_on;
use mlua::prelude::*;
use serde_json::{Map, Value};

use crate::api::plugin::PluginCallback;

pub(crate) struct LuauStorageUserData(pub(crate) PluginCallback);

impl LuauStorageUserData {
    fn read(&self) -> LuaResult<Map<String, Value>> {
        let read = self.0.storage_read.clone();
        let raw = block_on(read());
        match serde_json::from_str::<Value>(&raw).map_err(mlua::Error::external)? {
            Value::Object(values) => Ok(values),
            _ => Ok(Map::new()),
        }
    }

    fn write(&self, values: Map<String, Value>) -> LuaResult<()> {
        let write = self.0.storage_write.clone();
        let raw = serde_json::to_string(&values).map_err(mlua::Error::external)?;
        block_on(write(raw));
        Ok(())
    }
}

impl LuaUserData for LuauStorageUserData {
    fn add_methods<M: LuaUserDataMethods<Self>>(methods: &mut M) {
        methods.add_method("Get", |lua, this, key: Option<String>| {
            let values = this.read()?;
            let value = match key {
                Some(key) => values.get(&key).cloned().unwrap_or(Value::Null),
                None => Value::Object(values),
            };
            lua.to_value(&value).map_err(mlua::Error::external)
        });

        methods.add_method("Set", |lua, this, (key, value): (String, LuaValue)| {
            let mut values = this.read()?;
            let value: Value = lua.from_value(value).map_err(mlua::Error::external)?;
            if value.is_null() {
                values.remove(&key);
            } else {
                values.insert(key, value);
            }
            this.write(values)
        });

        methods.add_method("Remove", |_, this, key: String| {
            let mut values = this.read()?;
            values.remove(&key);
            this.write(values)
        });

        methods.add_method("Clear", |_, this, ()| this.write(Map::new()));
    }
}
