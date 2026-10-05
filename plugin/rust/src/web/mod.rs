use crate::api::{
    luau::LuauPlugin,
    plugin::{PluginCallback, RustPlugin},
};
use futures::{channel::oneshot, task::noop_waker};
use serde::Deserialize;
use serde_json::{Value, json};
use std::{
    cell::RefCell,
    collections::HashMap,
    ffi::{CStr, CString, c_char},
    future::Future,
    pin::Pin,
    sync::Arc,
    task::{Context, Poll},
};

type TaskFuture = Pin<Box<dyn Future<Output = anyhow::Result<Value>>>>;
struct Task {
    plugin: u32,
    future: TaskFuture,
}
#[derive(Default)]
struct Runtime {
    next_plugin: u32,
    next_task: u32,
    next_request: u32,
    plugins: HashMap<u32, Arc<LuauPlugin>>,
    tasks: HashMap<u32, Task>,
    requests: HashMap<u32, (u32, oneshot::Sender<anyhow::Result<()>>)>,
}
thread_local! { static RUNTIME: RefCell<Runtime> = RefCell::new(Runtime::default()); }

unsafe extern "C" {
    fn setonix_report_error(message: *const c_char);
    fn setonix_host_sync(plugin: u32, method: *const c_char, args: *const c_char) -> *mut c_char;
    fn setonix_host_async(plugin: u32, request: u32, method: *const c_char, args: *const c_char);
    fn free(ptr: *mut std::ffi::c_void);
}

fn sync_host(plugin: u32, method: &str, args: Value) -> Value {
    let method = CString::new(method).unwrap();
    let args = CString::new(args.to_string()).unwrap();
    let ptr = unsafe { setonix_host_sync(plugin, method.as_ptr(), args.as_ptr()) };
    let value = unsafe { CStr::from_ptr(ptr) }
        .to_string_lossy()
        .into_owned();
    unsafe { free(ptr.cast()) };
    serde_json::from_str(&value).expect("invalid host response")
}

fn string_host(plugin: u32, method: &str, args: Value) -> String {
    sync_host(plugin, method, args)
        .as_str()
        .expect("host response is not a string")
        .to_owned()
}

async fn async_host(plugin: u32, method: &str, args: Value) -> anyhow::Result<()> {
    let (sender, receiver) = oneshot::channel();
    let request = RUNTIME.with(|runtime| {
        let mut runtime = runtime.borrow_mut();
        runtime.next_request += 1;
        let request = runtime.next_request;
        runtime.requests.insert(request, (plugin, sender));
        request
    });
    let method = CString::new(method)?;
    let args = CString::new(args.to_string())?;
    unsafe { setonix_host_async(plugin, request, method.as_ptr(), args.as_ptr()) };
    receiver.await?
}

fn callback(plugin: u32) -> PluginCallback {
    PluginCallback::new(
        move |message| {
            sync_host(plugin, "onPrint", json!([message]));
            Box::pin(async {})
        },
        move |event, force| {
            Box::pin(async move { async_host(plugin, "processEvent", json!([event, force])).await })
        },
        move |event, target| {
            Box::pin(async move { async_host(plugin, "sendEvent", json!([event, target])).await })
        },
        move |field| {
            let value = string_host(plugin, "stateFieldAccess", json!([field.to_string()]));
            Box::pin(async move { value })
        },
        move |table| {
            let value = string_host(plugin, "tableAccess", json!([table]));
            Box::pin(async move { value })
        },
        move || {
            let value = string_host(plugin, "storageRead", json!([]));
            Box::pin(async move { value })
        },
        move |storage| {
            sync_host(plugin, "storageWrite", json!([storage]));
            Box::pin(async {})
        },
    )
}

fn output(value: Value) -> *mut c_char {
    CString::new(value.to_string()).unwrap().into_raw()
}

unsafe fn input<'a>(value: *const c_char) -> &'a str {
    unsafe { CStr::from_ptr(value) }
        .to_str()
        .expect("invalid UTF-8 input")
}

/// # Safety
/// `code` must point to a valid, null-terminated UTF-8 string until this call returns.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn create_plugin(code: *const c_char) -> u32 {
    let id = RUNTIME.with(|runtime| {
        let mut r = runtime.borrow_mut();
        r.next_plugin += 1;
        r.next_plugin
    });
    let plugin = LuauPlugin::new(unsafe { input(code) }.to_owned(), callback(id));
    RUNTIME.with(|runtime| runtime.borrow_mut().plugins.insert(id, Arc::new(plugin)));
    id
}

#[derive(Deserialize)]
#[serde(rename_all = "camelCase")]
struct EventInput {
    event_type: String,
    event: String,
    server_event: Option<String>,
    source: i16,
    cancelled: bool,
    target: i16,
}

/// # Safety
/// `event` must point to a valid, null-terminated UTF-8 string until this call returns.
/// The caller must release the returned JSON string with `free_result`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn start_task(plugin: u32, event: *const c_char) -> *mut c_char {
    let engine = RUNTIME.with(|runtime| runtime.borrow().plugins.get(&plugin).cloned());
    let Some(engine) = engine else {
        return output(json!({"error": "Plugin has been disposed"}));
    };
    let event = unsafe { input(event) };
    let future: TaskFuture = if event.is_empty() {
        Box::pin(async move {
            engine.run().await?;
            Ok(Value::Null)
        })
    } else {
        let event: EventInput = match serde_json::from_str(event) {
            Ok(event) => event,
            Err(error) => return output(json!({"error": error.to_string()})),
        };
        // The shared plugin accepts JSON objects. Validate before calling its API.
        if serde_json::from_str::<crate::api::plugin::JsonObject>(&event.event).is_err()
            || event.server_event.as_ref().is_some_and(|event| {
                serde_json::from_str::<crate::api::plugin::JsonObject>(event).is_err()
            })
        {
            return output(json!({"error": "Event payload must be a JSON object"}));
        }
        Box::pin(async move {
            let result = engine
                .run_event(
                    event.event_type,
                    event.event,
                    event.server_event,
                    event.source,
                    event.cancelled,
                    event.target,
                )
                .await;
            Ok(serde_json::to_value(result)?)
        })
    };
    let task = RUNTIME.with(|runtime| {
        let mut runtime = runtime.borrow_mut();
        runtime.next_task += 1;
        let id = runtime.next_task;
        runtime.tasks.insert(id, Task { plugin, future });
        id
    });
    output(json!({"task": task}))
}

#[unsafe(no_mangle)]
pub extern "C" fn poll_task(id: u32) -> *mut c_char {
    // Host requests re-enter the registry, so never hold its borrow while polling Lua.
    let task = RUNTIME.with(|runtime| runtime.borrow_mut().tasks.remove(&id));
    let Some(mut task) = task else {
        return output(json!({"error": "Task has been disposed"}));
    };
    let waker = noop_waker();
    match task.future.as_mut().poll(&mut Context::from_waker(&waker)) {
        Poll::Pending => {
            RUNTIME.with(|runtime| runtime.borrow_mut().tasks.insert(id, task));
            output(json!({"pending": true}))
        }
        Poll::Ready(Ok(value)) => output(json!({"value": value})),
        Poll::Ready(Err(error)) => output(json!({"error": error.to_string()})),
    }
}

/// # Safety
/// `response` must point to a valid, null-terminated UTF-8 JSON string until this call returns.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn complete_callback(request: u32, response: *const c_char) {
    let response: Value = serde_json::from_str(unsafe { input(response) }).unwrap();
    let sender = RUNTIME.with(|runtime| runtime.borrow_mut().requests.remove(&request));
    if let Some((_, sender)) = sender {
        let result = response
            .get("error")
            .and_then(Value::as_str)
            .map_or(Ok(()), |error| Err(anyhow::anyhow!(error.to_owned())));
        let _ = sender.send(result);
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn destroy_plugin(plugin: u32) {
    RUNTIME.with(|runtime| {
        let mut runtime = runtime.borrow_mut();
        runtime.tasks.retain(|_, task| task.plugin != plugin);
        runtime.requests.retain(|_, (id, _)| *id != plugin);
        runtime.plugins.remove(&plugin);
    });
}

/// # Safety
/// `result` must be null or an unreleased pointer returned by `start_task` or `poll_task`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn free_result(result: *mut c_char) {
    if !result.is_null() {
        drop(unsafe { CString::from_raw(result) });
    }
}

pub fn main() {
    std::panic::set_hook(Box::new(|info| {
        if let Ok(message) = CString::new(info.to_string()) {
            unsafe { setonix_report_error(message.as_ptr()) };
        }
    }));
}
