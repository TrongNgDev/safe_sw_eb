#!/bin/sh -e

BINARY_DUMP_TOOL="../../tools/bin/binarydump"
WAMRC_TOOL="../../tools/bin/wamrc"
WASM_TARGET="wasm32-wasip1"
#WASM_TARGET="wasm32-unknown-unknown"

rm -rf target
export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add $WASM_TARGET


echo "Build Wasm application from Rust, target "$WASM_TARGET".."
cargo build --release --target $WASM_TARGET
cp -f target/"$WASM_TARGET"/release/image_app_Rust.wasm ./image_app.wasm


# Compile Wasm to AoT, target riscv32 ilp32 (for esp32c6/r9a02g021)
echo ""
$WAMRC_TOOL     --target=riscv32 \
                --target-abi=ilp32 \
                --cpu=generic-rv32 \
                --cpu-features=+m \
                -o image_app_riscv32_ilp32.aot \
                   image_app.wasm

# Compile Wasm to AoT, target x86_64 gnu (for linux)
echo ""
$WAMRC_TOOL     --target=x86_64 \
                --target-abi=gnu \
                -o image_app_x86_64_gnu.aot \
                   image_app.wasm

echo "\nBinary-dump Wasm file to C header file .."
$BINARY_DUMP_TOOL -o image_app_wasm.h \
                  -n wasm_application_file \
                     image_app.wasm

echo "Binary-dump WAMR's AoT file to C header file .."
$BINARY_DUMP_TOOL -o image_app_riscv32_ilp32_aot.h \
                  -n wasm_application_file \
                     image_app_riscv32_ilp32.aot

echo "\nDone!"