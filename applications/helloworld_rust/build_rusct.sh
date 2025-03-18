#!/bin/sh -e

export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add wasm32-wasip1

# Build rustc
echo "Build wasm app from rusct .."
rm -rf target  && mkdir target && cd target
rustc   -C link-self-contained=no \
        -C link-arg=--initial-memory=65536 \
        -C link-args=-zstack-size=128 \
        -C link-args=--export=__heap_base \
        -C link-args=--export=__data_end \
        -C link-args=--no-entry \
        --target wasm32-wasip1 \
        ../src/main.rs
cp -f main.wasm ../helloworld_rusct.wasm
cd ../

# Binary dump using binarydump-tool from WAMR
echo "Binary dump Wasm file to helloworld_wasm_rusct.h .."
../../tools/bin/binarydump \
        -o helloworld_wasm_rusct.h \
        -n wasm_application_file \
           helloworld_rusct.wasm

echo "Done"