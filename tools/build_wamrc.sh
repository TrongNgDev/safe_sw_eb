#!/bin/sh

echo "Build wamrc AoT tool .."

CURRENT_DIR="$(pwd)"
TOOL_BIN_DIR="$CURRENT_DIR/bin/test"
WASM_DIR="../linux/linux_wamr/WAMR/wasm-micro-runtime/wamr-compiler/"

cd $WASM_DIR
./build_llvm.sh
rm -rf build && mkdir build && cd build
cmake ..
make

cp -f wamrc $TOOL_BIN_DIR
