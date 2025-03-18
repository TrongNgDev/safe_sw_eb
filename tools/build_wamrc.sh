#!/bin/sh

echo "Build wamrc AoT tool .."

cd wasm-micro-runtime/wamr-compiler
./build_llvm.sh

rm -rf build && mkdir build && cd build
cmake ..
make

cp -f wamrc ../../../bin