#!/bin/sh

BINARY_DUMP_TOOL="../../tools/bin/binarydump"
WAMRC_TOOL="../../tools/bin/wamrc"


echo "Build Wasm application from C.."
/opt/wasi-sdk/bin/clang -O3 \
        -z stack-size=192 -Wl,--initial-memory=65536 \
        -o helloworld.wasm src/helloworld.c \
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
                -o helloworld.aot \
                   helloworld.wasm

echo "\nBinary-dump Wasm file to C header file .."
$BINARY_DUMP_TOOL -o helloworld_wasm.h \
                  -n wasm_application_file \
                     helloworld.wasm

echo "Binary-dump WAMR's AoT file to C header file .."
$BINARY_DUMP_TOOL -o helloworld_wasm_aot.h \
                  -n wasm_application_file \
                     helloworld.aot

echo "Done" 