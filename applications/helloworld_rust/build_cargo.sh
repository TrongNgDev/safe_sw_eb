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
cp -f target/wasm32-wasip1/release/helloworld-rust.wasm ./helloworld_cargo.wasm

# Binary dump using binarydump-tool from WAMR
echo "Binary dump Wasm file to helloworld_wasm_cargo.h .."
../../tools/bin/binarydump \
        -o helloworld_wasm_cargo.h \
        -n wasm_application_file \
        helloworld_cargo.wasm

echo "Done"
