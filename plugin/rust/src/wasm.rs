//! Minimal browser facilities needed by Luau's WASI C runtime.
//! Dart/Rust bindings and asynchronous calls use flutter_rust_bridge directly.
use flutter_rust_bridge::for_generated::wasm_bindgen::{self, prelude::*};
use std::sync::Once;

unsafe extern "C" {
    fn __wasm_call_ctors();
}

pub(crate) fn initialize() {
    static INITIALIZED: Once = Once::new();
    INITIALIZED.call_once(|| unsafe { __wasm_call_ctors() });
}

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = Date, js_name = now)]
    fn date_now() -> f64;
    #[wasm_bindgen(js_namespace = performance, js_name = now)]
    fn performance_now() -> f64;
    #[wasm_bindgen(js_namespace = console, js_name = log)]
    fn console_log(message: &str);
    #[wasm_bindgen(js_namespace = console, js_name = error)]
    fn console_error(message: &str);
}

// Resolve WASI libc's imports inside the module so wasm-bindgen generates a
// self-contained browser loader, with no additional JS modules or WASI shim.
#[unsafe(no_mangle)]
unsafe extern "C" fn __imported_wasi_snapshot_preview1_environ_sizes_get(
    count: *mut u32,
    size: *mut u32,
) -> u32 {
    unsafe {
        count.write(0);
        size.write(0);
    }
    0
}

#[unsafe(no_mangle)]
extern "C" fn __imported_wasi_snapshot_preview1_environ_get(_: u32, _: u32) -> u32 {
    0
}

#[unsafe(no_mangle)]
unsafe extern "C" fn __imported_wasi_snapshot_preview1_clock_time_get(
    clock: u32,
    _: u64,
    result: *mut u64,
) -> u32 {
    let milliseconds = match clock {
        0 => date_now(),
        1 => performance_now(),
        _ => return 28, // EINVAL
    };
    unsafe {
        result.write((milliseconds * 1_000_000.0) as u64);
    }
    0
}

#[repr(C)]
struct IoVector {
    pointer: *const u8,
    length: usize,
}

#[unsafe(no_mangle)]
unsafe extern "C" fn __imported_wasi_snapshot_preview1_fd_write(
    fd: u32,
    vectors: *const IoVector,
    count: usize,
    written: *mut usize,
) -> u32 {
    if fd != 1 && fd != 2 {
        return 8;
    } // EBADF
    let mut output = String::new();
    let mut size = 0;
    for vector in unsafe { std::slice::from_raw_parts(vectors, count) } {
        let bytes = unsafe { std::slice::from_raw_parts(vector.pointer, vector.length) };
        output.push_str(&String::from_utf8_lossy(bytes));
        size += vector.length;
    }
    unsafe {
        written.write(size);
    }
    if fd == 2 {
        console_error(&output);
    } else {
        console_log(&output);
    }
    0
}

#[unsafe(no_mangle)]
extern "C" fn __imported_wasi_snapshot_preview1_fd_close(_: u32) -> u32 {
    8
}
#[unsafe(no_mangle)]
extern "C" fn __imported_wasi_snapshot_preview1_fd_fdstat_get(_: u32, _: u32) -> u32 {
    8
}
#[unsafe(no_mangle)]
extern "C" fn __imported_wasi_snapshot_preview1_fd_seek(_: u32, _: i64, _: u32, _: u32) -> u32 {
    8
}
#[unsafe(no_mangle)]
extern "C" fn __imported_wasi_snapshot_preview1_proc_exit(code: u32) -> ! {
    flutter_rust_bridge::for_generated::wasm_bindgen::throw_str(&format!(
        "Luau runtime exited ({code})"
    ))
}

use std::alloc::{GlobalAlloc, Layout};
use std::ffi::c_void;

// Rust and WASI libc share linear memory and must use the same heap.
// This follows mlua's tests/wasm allocator, including over-aligned allocations.
struct WasiAllocator;

unsafe extern "C" {
    fn posix_memalign(ptr: *mut *mut c_void, align: usize, size: usize) -> i32;
    fn free(ptr: *mut c_void);
}

unsafe impl GlobalAlloc for WasiAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let mut ptr = std::ptr::null_mut();
        if unsafe {
            posix_memalign(
                &mut ptr,
                layout.align().max(size_of::<usize>()),
                layout.size(),
            )
        } != 0
        {
            return std::ptr::null_mut();
        }
        ptr.cast()
    }

    unsafe fn dealloc(&self, ptr: *mut u8, _: Layout) {
        unsafe { free(ptr.cast()) };
    }
}

#[global_allocator]
static ALLOCATOR: WasiAllocator = WasiAllocator;
