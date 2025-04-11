#!/bin/sh -e

BINARY_DUMP_TOOL="../../tools/bin/binarydump"
WAMRC_TOOL="../../tools/bin/wamrc"
WASM_TARGET="wasm32-wasip1"
#WASM_TARGET="wasm32-unknown-unknown"

rm -rf target
export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add $WASM_TARGET


echo "Build Wasm application from Rust (using rustc command), target "$WASM_TARGET".."
rm -rf target  && mkdir target && cd target
rustc   -C link-self-contained=no \
        -C link-arg=--initial-memory=65536 \
        -C link-args=-zstack-size=128 \
        -C link-args=--export=__heap_base \
        -C link-args=--export=__data_end \
        -C link-args=--no-entry \
        --target "$WASM_TARGET" \
        ../src/main.rs
cp -f main.wasm ../helloworld_rusct.wasm
cd ../


echo "\nBinary-dump Wasm file to C header file .."
$BINARY_DUMP_TOOL -o helloworld_rusct_wasm.h \
                  -n wasm_application_file \
                     helloworld_rusct.wasm

echo "Done!"