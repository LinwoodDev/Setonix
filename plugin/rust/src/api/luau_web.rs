use flutter_rust_bridge::frb;

use super::plugin::{Channel, EventResult, PluginCallback, RustPlugin};

pub struct LuauPlugin {
    _code: String,
    _callback: PluginCallback,
}

impl RustPlugin for LuauPlugin {
    async fn run_event(
        &self,
        _event_type: String,
        _event: String,
        server_event: Option<String>,
        source: Channel,
        cancelled: bool,
        target: Channel,
    ) -> EventResult {
        let _ = source;
        EventResult {
            target,
            server_event,
            needs_update: None,
            cancelled,
            scheduled_events: Vec::new(),
        }
    }

    async fn run(&self) -> Result<(), anyhow::Error> {
        anyhow::bail!(
            "Luau plugins are not supported on wasm32-unknown-unknown. Use wasm32-unknown-emscripten or disable scripted plugins on web."
        );
    }
}

impl LuauPlugin {
    #[frb(sync)]
    pub fn new(code: String, callback: PluginCallback) -> LuauPlugin {
        Self {
            _code: code,
            _callback: callback,
        }
    }
}
