#!/bin/sh

echo "Build binarydump tool .."

CURRENT_DIR="$(pwd)"
TOOL_BIN_DIR="$CURRENT_DIR/bin/"
WASM_DIR="../linux/linux_wamr/WAMR/wasm-micro-runtime/test-tools/binarydump-tool/"

cd $WASM_DIR
rm -rf build && mkdir build && cd build
cmake ..
make all

cp -f binarydump $TOOL_BIN_DIR
