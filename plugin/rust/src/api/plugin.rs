
use std::{collections::HashSet, sync::Arc};

use flutter_rust_bridge::{frb, DartFnFuture};
use serde::{Deserialize, Serialize};
use serde_json::{Map, Value};


pub type DartCallback<T> = Arc<dyn Fn(T) -> DartFnFuture<()> + Send + Sync>;
// see https://github.com/rust-lang/lang-team/blob/master/src/design_notes/variadic_generics.md
// for more information on variadic generics
pub type DartCallback2<T, U> = Arc<dyn Fn(T, U) -> DartFnFuture<anyhow::Result<()>> + Send + Sync>;
pub type DartAccess<T, R> = Arc<dyn Fn(T) -> DartFnFuture<R> + Send + Sync>;

#[derive(strum::Display, strum::EnumIter, Clone, Copy)]
pub enum StateFieldAccess {
    TableName,
    Tables,
    Info,
    Players,
    TeamMembers,
    Namespace,
    Game,
}

#[derive(Clone)]
pub struct PluginCallback {
    pub(crate) on_print: DartCallback<String>,
    pub(crate) process_event: DartCallback2<String, Option<bool>>,
    pub(crate) send_event: DartCallback2<String, Option<Channel>>,
    pub(crate) state_field_access: DartAccess<StateFieldAccess, String>,
    pub(crate) table_access: DartAccess<Option<String>, String>,
}

impl PluginCallback {
    #[frb(sync)]
    pub fn new(
        on_print: impl Fn(String) -> DartFnFuture<()> + 'static + Send + Sync,
        process_event: impl Fn(String, Option<bool>) -> DartFnFuture<anyhow::Result<()>> + 'static + Send + Sync,
        send_event: impl Fn(String, Option<Channel>) -> DartFnFuture<anyhow::Result<()>> + 'static + Send + Sync,
        state_field_access: impl Fn(StateFieldAccess) -> DartFnFuture<String> + 'static + Send + Sync,
        table_access: impl Fn(Option<String>) -> DartFnFuture<String> + 'static + Send + Sync,
    ) -> Self {
        Self {
            on_print: Arc::new(Box::new(on_print)),
            process_event: Arc::new(Box::new(process_event)),
            send_event: Arc::new(Box::new(send_event)),
            state_field_access: Arc::new(Box::new(state_field_access)),
            table_access: Arc::new(Box::new(table_access)),
        }
    }
}

pub type Channel = i16;
pub type JsonObject = Map<String, Value>;

pub(crate) trait RustPlugin {
    async fn run_event(&self, event_type: String, event: String, server_event: String, source: Channel, cancelled: bool, target: Channel) -> EventResult;
    async fn run(&self) -> Result<(), anyhow::Error>;
}

#[derive(Serialize, Deserialize, Clone)]
pub(crate) struct EventDetails {
    pub(crate) source: Channel,
    pub(crate) server_event: JsonObject,
    pub(crate) target: Channel,
    pub(crate) cancelled: bool,
    pub(crate) needs_update: Option<HashSet<Channel>>,
    pub(crate) scheduled_events: Vec<(String, Channel)>,
}

impl EventDetails {
    pub(crate) fn new(
        server_event: JsonObject,
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
        let server_event = if previous.map_or(false, |prev| prev.server_event != details.server_event) {
            serde_json::to_string(&details.server_event).ok()
        } else {
            None
        };
        Self {
            target: details.target,
            server_event: server_event,
            needs_update: details.needs_update,
            cancelled: details.cancelled,
            scheduled_events: details.scheduled_events,
        }
    }
}
