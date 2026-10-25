use std::{
    collections::{HashMap, HashSet},
    sync::Arc,
};

use flutter_rust_bridge::{DartFnFuture, frb};
use serde::{Deserialize, Serialize};
use serde_json::{Map, Value};

pub type DartCallback2<T, U> = Arc<dyn Fn(T, U) -> DartFnFuture<anyhow::Result<()>> + Send + Sync>;

#[derive(strum::Display, strum::EnumIter, Clone, Copy, PartialEq, Eq, Hash)]
pub enum StateFieldAccess {
    TableName,
    Tables,
    Info,
    Players,
    TeamMembers,
    GameRoles,
    Namespace,
    Game,
}

/// Ordered side effects produced by synchronous Lua callbacks.
pub struct PluginEffect {
    pub method: String,
    pub value: String,
}

#[derive(Default)]
#[frb(ignore)]
struct HostState {
    fields: HashMap<StateFieldAccess, String>,
    tables: HashMap<String, String>,
    current_table: String,
    storage: String,
    effects: Vec<PluginEffect>,
}

#[derive(Clone)]
pub struct PluginCallback {
    pub(crate) process_event: DartCallback2<String, Option<bool>>,
    pub(crate) send_event: DartCallback2<String, Option<Channel>>,
    host: Arc<std::sync::Mutex<HostState>>,
}

impl PluginCallback {
    #[frb(sync)]
    pub fn new(
        process_event: impl Fn(String, Option<bool>) -> DartFnFuture<anyhow::Result<()>>
        + 'static
        + Send
        + Sync,
        send_event: impl Fn(String, Option<Channel>) -> DartFnFuture<anyhow::Result<()>>
        + 'static
        + Send
        + Sync,
    ) -> Self {
        Self {
            process_event: Arc::new(process_event),
            send_event: Arc::new(send_event),
            host: Arc::new(std::sync::Mutex::new(HostState::default())),
        }
    }

    /// Refresh synchronous getters before Lua runs and after asynchronous host calls.
    #[frb(sync)]
    pub fn set_snapshot(
        &self,
        fields: HashMap<StateFieldAccess, String>,
        tables: HashMap<String, String>,
        current_table: String,
        storage: String,
    ) {
        let mut host = self.host.lock().unwrap();
        host.fields = fields;
        host.tables = tables;
        host.current_table = current_table;
        host.storage = storage;
    }

    #[frb(sync)]
    pub fn take_effects(&self) -> Vec<PluginEffect> {
        std::mem::take(&mut self.host.lock().unwrap().effects)
    }
}

impl PluginCallback {
    pub(crate) fn on_print(&self, value: String) {
        self.host.lock().unwrap().effects.push(PluginEffect {
            method: "onPrint".into(),
            value,
        });
    }

    pub(crate) fn state_field_access(&self, field: StateFieldAccess) -> String {
        self.host
            .lock()
            .unwrap()
            .fields
            .get(&field)
            .cloned()
            .unwrap_or_else(|| "null".into())
    }

    pub(crate) fn table_access(&self, name: Option<String>) -> String {
        let host = self.host.lock().unwrap();
        match name {
            Some(name) => host
                .tables
                .get(&name)
                .cloned()
                .unwrap_or_else(|| "{}".into()),
            None => host.current_table.clone(),
        }
    }

    pub(crate) fn storage_read(&self) -> String {
        self.host.lock().unwrap().storage.clone()
    }

    pub(crate) fn storage_write(&self, value: String) {
        let mut host = self.host.lock().unwrap();
        host.storage = value.clone();
        host.effects.push(PluginEffect {
            method: "storageWrite".into(),
            value,
        });
    }
}

pub type Channel = i16;
pub type JsonObject = Map<String, Value>;

pub(crate) trait RustPlugin {
    async fn run_event(
        &self,
        event_type: String,
        event: String,
        server_event: Option<String>,
        source: Channel,
        cancelled: bool,
        target: Channel,
    ) -> EventResult;
    async fn run(&self) -> Result<(), anyhow::Error>;
}

#[derive(Serialize, Deserialize, Clone)]
pub(crate) struct EventDetails {
    pub(crate) source: Channel,
    pub(crate) server_event: Option<JsonObject>,
    pub(crate) target: Channel,
    pub(crate) cancelled: bool,
    pub(crate) needs_update: Option<HashSet<Channel>>,
    pub(crate) scheduled_events: Vec<(String, Channel)>,
}

impl EventDetails {
    pub(crate) fn new(
        server_event: Option<JsonObject>,
        target: Channel,
        source: Channel,
        cancelled: bool,
        needs_update: Option<HashSet<Channel>>,
    ) -> Self {
        Self {
            server_event,
            target,
            source,
            cancelled,
            needs_update,
            scheduled_events: Vec::new(),
        }
    }

    pub(crate) fn schedule_event(&mut self, event: String, channel: Option<Channel>) {
        self.scheduled_events.push((event, channel.unwrap_or(0)));
    }
}

#[derive(Serialize, Deserialize)]
pub struct EventResult {
    pub target: Channel,
    pub server_event: Option<String>,
    pub needs_update: Option<HashSet<Channel>>,
    pub cancelled: bool,
    pub scheduled_events: Vec<(String, Channel)>,
}

impl EventResult {
    pub(crate) fn build(details: EventDetails, previous: Option<EventDetails>) -> Self {
        let server_event = if previous.is_some_and(|prev| prev.server_event != details.server_event)
        {
            serde_json::to_string(&details.server_event).ok()
        } else {
            None
        };
        Self {
            target: details.target,
            server_event,
            needs_update: details.needs_update,
            cancelled: details.cancelled,
            scheduled_events: details.scheduled_events,
        }
    }
}
