#!/bin/sh -e

rm -rf target

export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add wasm32-wasip1

# Config in .cargo/config.toml
#rustflags = [
#  "-C", "link-self-contained=no",
#  "-C", "link-arg=--initial-memory=65536",
#  "-C", "link-arg=-zstack-size=128",
#  "-C", "link-arg=--export=__data_end",
#  "-C", "link-arg=--strip-all",
#  "-C", "link-args=--no-entry",
#]

# Build release
echo "Build wasm app from cargo build .."
cargo build --release --target wasm32-wasip1
cp -f target/wasm32-wasip1/release/image_app_Rust.wasm ./image_app.wasm

# Binary dump using binarydump-tool from WAMR
echo "Binary dump Wasm file to .h .."
../../tools/bin/binarydump \
        -o image_app_wasm.h \
        -n wasm_application_file \
        image_app.wasm

echo "Generate Wasm AoT app .."
../../tools/bin/wamrc --target=riscv32 \
        --target-abi=ilp32d \
        -o image_app.aot \
        image_app.wasm

echo "Generate image_app_wasm_aot.h .."
../../tools/bin/binarydump \
        -o image_app_wasm_aot.h \
        -n wasm_application_file \
        image_app.aot

echo "Done"
