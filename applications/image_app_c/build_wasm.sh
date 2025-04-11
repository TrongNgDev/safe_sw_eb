#!/bin/sh

BINARY_DUMP_TOOL="../../tools/bin/binarydump"
WAMRC_TOOL="../../tools/bin/wamrc"


echo "Build Wasm application from C.."
/opt/wasi-sdk/bin/clang -O3 -flto \
        -z stack-size=256 -Wl,--initial-memory=65536 \
        -o image_app.wasm src/image_app.c \
        -Wl,--export=main -Wl,--export=__main_argc_argv \
        -Wl,--export=__data_end -Wl,--export=__heap_base \
        -Wl,--strip-all,--no-entry \
        -Wl,--allow-undefined \
        -nostdlib


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

echo "Done" 