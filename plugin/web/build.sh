#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
output="${1:-../../app/web/pkg}"
wasm_bindgen="${WASM_BINDGEN:-wasm-bindgen}"
[[ "$("$wasm_bindgen" --version)" == 'wasm-bindgen 0.2.129' ]] || { echo 'wasm-bindgen-cli 0.2.129 is required (matching Cargo.lock).' >&2; exit 1; }
: "${WASI_SDK_PATH:?Set WASI_SDK_PATH to WASI SDK 34.0}"
[[ "$(head -n 1 "$WASI_SDK_PATH/VERSION")" == 34.0 ]] || { echo 'WASI SDK 34.0 is required.' >&2; exit 1; }
sysroot="$WASI_SDK_PATH/share/wasi-sysroot/lib/wasm32-wasip1"
[[ -d "$sysroot/eh" ]] || { echo 'WASI SDK with exception support is required (34.0).' >&2; exit 1; }

# Rust uses the bare Wasm target; Luau's C++ code uses WASI libc and exceptions.
# Keep these in step with mlua's tests/wasm/setup.sh.
export CC_wasm32_unknown_unknown="$WASI_SDK_PATH/bin/clang"
export CXX_wasm32_unknown_unknown="$WASI_SDK_PATH/bin/clang++"
export AR_wasm32_unknown_unknown="$WASI_SDK_PATH/bin/llvm-ar"
export CXXSTDLIB_wasm32_unknown_unknown=c++
export CFLAGS_wasm32_unknown_unknown="--target=wasm32-wasip1"
export LUAU_CXXFLAGS="--target=wasm32-wasip1 -fexceptions -fwasm-exceptions -mllvm -wasm-use-legacy-eh=false"
# Encoded flags preserve paths containing spaces and the offline builder's flags.
# Export constructors so wasm-ld does not wrap every exported call in command
# constructors/destructors. This is a persistent reactor, initialized once by JS.
flags=(-L "native=$sysroot/eh" -L "native=$sysroot" -l static=c++abi -l static=unwind -l static=wasi-emulated-process-clocks -l static=c -C link-arg=--export=__wasm_call_ctors)
if [[ ! -v CARGO_ENCODED_RUSTFLAGS ]]; then
  # Cargo's plain RUSTFLAGS uses whitespace-separated arguments.
  read -r -a inherited_flags <<< "${RUSTFLAGS:-${CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_RUSTFLAGS:-}}"
  CARGO_ENCODED_RUSTFLAGS="$(IFS=$'\x1f'; echo "${inherited_flags[*]}")"
fi
for flag in "${flags[@]}"; do
  CARGO_ENCODED_RUSTFLAGS+="${CARGO_ENCODED_RUSTFLAGS:+$'\x1f'}$flag"
done
export CARGO_ENCODED_RUSTFLAGS

cargo build --manifest-path ../rust/Cargo.toml --locked --release --target wasm32-unknown-unknown --lib
mkdir -p "$output"
"$wasm_bindgen" "${CARGO_TARGET_DIR:-../rust/target}/wasm32-unknown-unknown/release/setonix_plugin.wasm" \
  --target no-modules --out-dir "$output" --out-name setonix_plugin --no-typescript
# Remove the old custom transport's generated artifacts from existing folders.
rm -f "$output/setonix_luau.js" "$output/setonix_luau.wasm" "$output/setonix_luau_runtime.js"
