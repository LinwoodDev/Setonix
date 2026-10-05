#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
output="${1:-../../app/web/pkg}"
command -v emcc >/dev/null || { echo 'Activate emsdk before building the web plugin.' >&2; exit 1; }
# Cargo also builds the library target alongside the browser executable.
# Luau's C++ objects must support both the library and executable link modes.
export LUAU_CXXFLAGS="${LUAU_CXXFLAGS:-} -fPIC"
export RUSTFLAGS="${RUSTFLAGS:-} -C link-arg=-sDEFAULT_TO_CXX -C link-arg=-fwasm-exceptions"
cargo build --manifest-path ../rust/Cargo.toml --locked --release --target wasm32-unknown-emscripten --features web-runtime --bin setonix_luau
mkdir -p "$output"
cp ../rust/target/wasm32-unknown-emscripten/release/setonix_luau.{js,wasm} "$output/"
cp runtime.js "$output/setonix_luau_runtime.js"
