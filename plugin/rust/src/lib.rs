pub mod api;

#[cfg(not(target_os = "emscripten"))]
mod frb_generated;

#[cfg(target_os = "emscripten")]
pub mod web;
