pub mod luau;
pub mod plugin;

/// Initialize the C++ runtime once when the generated bridge starts.
#[flutter_rust_bridge::frb(init)]
pub async fn initialize_runtime() {
    #[cfg(target_family = "wasm")]
    crate::wasm::initialize();
}
