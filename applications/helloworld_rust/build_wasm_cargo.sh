#!/bin/sh -e

BINARY_DUMP_TOOL="../../tools/bin/binarydump"
WAMRC_TOOL="../../tools/bin/wamrc"
WASM_TARGET="wasm32-wasip1"
#WASM_TARGET="wasm32-unknown-unknown"

rm -rf target
export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add $WASM_TARGET


echo "Build Wasm application from Rust (using cargo build), target "$WASM_TARGET".."
cargo build --release --target $WASM_TARGET
cp -f target/"$WASM_TARGET"/release/helloworld-rust.wasm ./helloworld_cargo.wasm

echo "\nBinary-dump Wasm file to C header file .."
$BINARY_DUMP_TOOL -o helloworld_cargo_wasm.h \
                  -n wasm_application_file \
                     helloworld_cargo.wasm

echo "Done!"