fn main() {
    if std::env::var("CARGO_CFG_TARGET_OS").as_deref() != Ok("emscripten") {
        return;
    }
    cc::Build::new()
        .cargo_metadata(false)
        .pic(true)
        .file("src/web/host.c")
        .compile("setonix_host");
    // EM_JS bodies live in custom object sections, not archive function definitions.
    // Link the object directly so Emscripten retains its JavaScript imports.
    let out = std::path::PathBuf::from(std::env::var_os("OUT_DIR").unwrap());
    let object = std::fs::read_dir(out)
        .unwrap()
        .filter_map(Result::ok)
        .map(|entry| entry.path())
        .find(|path| path.to_string_lossy().ends_with("-host.o"))
        .expect("host callback object was not generated");
    println!("cargo:rustc-link-arg={}", object.display());
    println!("cargo:rerun-if-changed=src/web/host.c");

    // Loader settings belong to the browser executable, not the library target
    // Cargo builds alongside it. In particular, only the executable has main.
    for argument in [
        "-sALLOW_MEMORY_GROWTH=1",
        "-sENVIRONMENT=web,node",
        "-sNO_EXIT_RUNTIME=1",
        "-sMODULARIZE=1",
        "-sEXPORT_NAME=createSetonixLuau",
        "-sEXPORTED_FUNCTIONS=_main,_create_plugin,_start_task,_poll_task,_complete_callback,_destroy_plugin,_free_result",
        "-sEXPORTED_RUNTIME_METHODS=ccall,UTF8ToString",
    ] {
        println!("cargo:rustc-link-arg-bin=setonix_luau={argument}");
    }
}
