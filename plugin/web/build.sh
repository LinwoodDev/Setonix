#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
output="${1:-../../app/web/pkg}"
command -v emcc >/dev/null || { echo 'Activate emsdk before building the web plugin.' >&2; exit 1; }
# Rust treats cold-cache progress on stderr as a linker warning.
# Suppress Emscripten progress logs; compiler diagnostics stay enabled.
export EMCC_LOGGING=0
# Cargo also builds the library target alongside the browser executable.
# Luau's C++ objects must support both the library and executable link modes.
export LUAU_CXXFLAGS="${LUAU_CXXFLAGS:-} -fPIC"
# Rust 1.99 adds -sWASM_BIGINT, which Emscripten 6 deprecates. Silence that
# linker diagnostic while keeping Cargo's warnings-as-errors policy.
if [[ -v CARGO_ENCODED_RUSTFLAGS ]]; then
  export CARGO_ENCODED_RUSTFLAGS+=$'\x1f-C\x1flink-arg=-sDEFAULT_TO_CXX\x1f-C\x1flink-arg=-fwasm-exceptions\x1f-C\x1flink-arg=-Wno-deprecated'
else
  export RUSTFLAGS="${RUSTFLAGS:-} -C link-arg=-sDEFAULT_TO_CXX -C link-arg=-fwasm-exceptions -C link-arg=-Wno-deprecated"
fi
cargo build --manifest-path ../rust/Cargo.toml --locked --release --target wasm32-unknown-emscripten --features web-runtime --bin setonix_luau
mkdir -p "$output"
cp "${CARGO_TARGET_DIR:-../rust/target}/wasm32-unknown-emscripten/release/"setonix_luau.{js,wasm} "$output/"
cp runtime.js "$output/setonix_luau_runtime.js"
