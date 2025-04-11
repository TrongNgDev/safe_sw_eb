#!/bin/bash

PROJECT_DIR="/home/tdn/safe_sw_eb/r9a02g021"
projects=(
    "r9a02g021_wamr_AOT_C"
    "r9a02g021_wamr_AOT_Rust"
    "r9a02g021_wamr_interp_classic_C"
    "r9a02g021_wamr_interp_classic_Rust"
    "r9a02g021_wamr_interp_fast_C"
    "r9a02g021_wamr_interp_fast_Rust"
)


symbol_list_file=".tmp001"
symbol_elf_selected=".tmp003"

echo "Mode,WAMR Size,Wasm Application Size,Total Size"
for project in "${projects[@]}"; do
    echo -n "$project,"

    PROJECT_ELF_FILE="$PROJECT_DIR/$project/HardwareDebug/$project.elf"
    PROJECT_BIN_FILE="$PROJECT_DIR/$project/HardwareDebug/$project.bin"
    WAMR_DIR="$PROJECT_DIR/../esp32c6/wasm-micro-runtime/core"

    # List of WAMR symbols
    ctags -R --languages=C,C++ --c-kinds=f --c++-kinds=f --fields=+n -o - $WAMR_DIR | cut -f1 | sort -u > $symbol_list_file
    
    #nm -S $PROJECT_DIR/$project/build/$project.elf | awk '{print $4}' | sort -u | grep -E 'wasm|WASM|os_|_wrapper|aot|AOT|jit|JIT' >> $symbol_list_file
    # sort $symbol_list_file | uniq > .tmp002
    # mv .tmp002 $symbol_list_file && rm -f .tmp002  

    # Extract size of all symbols of WAMR from ELF file
    awk 'NR==FNR { sym[$1]; next } $4 in sym' $symbol_list_file <(nm -S $PROJECT_ELF_FILE) > $symbol_elf_selected  

    # Calc the total size of WAMR from the extracted symbols
    awk '{sum += strtonum("0x" $2)} END {printf "%d,", sum}' $symbol_elf_selected

    # Get the size of Wasm application from ELF file
    # (all C and Rust Wasm/AOT are dumped to .h with variable name wasm_application_file)
    nm -S $PROJECT_ELF_FILE | grep 'wasm_application_file' | awk '{printf "%d,", strtonum("0x"$2)}'

    # Remove temp file
    rm $symbol_list_file $symbol_elf_selected

    
    if [ -f "$PROJECT_BIN_FILE" ]; then
        size=$(stat -c%s "$PROJECT_BIN_FILE")
        echo "$size"
    else
        echo "File $PROJECT_BIN_FILE does not exist."
    fi
done
