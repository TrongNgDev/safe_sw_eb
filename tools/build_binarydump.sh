#!/bin/sh

echo "Build binarydump tool .."
cd wasm-micro-runtime/test-tools/binarydump-tool
rm -rf build && mkdir build && cd build
cmake ..
make all
cp -f binarydump ../../../../bin
