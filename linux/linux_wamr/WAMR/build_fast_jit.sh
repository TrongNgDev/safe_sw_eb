#!/bin/sh

rm -fr build && mkdir build
cd build

echo "Building iwasm - Fast JIT.."
cmake ..    -DWAMR_BUILD_INTERP=0 \
            -DWAMR_BUILD_FAST_INTERP=0 \
            -DWAMR_BUILD_AOT=0 \
            -DWAMR_BUILD_JIT=1 \
            -DWAMR_BUILD_FAST_JIT=1 \
            -DWAMR_BUILD_LIBC_BUILTIN=1 \
            -DWAMR_BUILD_LIBC_WASI=0 \
            -DWAMR_BUILD_MULTI_MODULE=0 \
            -DWAMR_BUILD_LIB_PTHREAD=0 \
            -DWAMR_BUILD_LIB_WASI_THREADS=0 \
            -DWAMR_BUILD_MINI_LOADER=0 \
            -DWAMR_BUILD_SIMD=0 \
            -DWAMR_BUILD_REF_TYPES=1 \
            -DWAMR_BUILD_DEBUG_INTERP=0 \
            -DWAMR_BUILD_SHARED=0

make -j ${nproc}
cd ..

cp -f build/iwasm iwasm_fast_jit

echo "Done!"