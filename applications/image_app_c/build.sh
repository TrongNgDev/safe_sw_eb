#!/bin/sh

echo "Build Wasm app .."
/opt/wasi-sdk/bin/clang -O3 \
        -z stack-size=512 -Wl,--initial-memory=65536 \
        -o image_app.wasm image_app.c \
        -Wl,--export=main -Wl,--export=__main_argc_argv \
        -Wl,--export=__data_end -Wl,--export=__heap_base \
        -Wl,--strip-all,--no-entry \
        -Wl,--allow-undefined \
        -nostdlib

echo "Generate image_app_wasm.h .."
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
