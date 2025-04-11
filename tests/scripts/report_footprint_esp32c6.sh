#!/bin/bash

PROJECT_DIR="../esp32c6"
projects=(
    "esp32c6_wamr_AOT_C"
    "esp32c6_wamr_AOT_Rust"
    "esp32c6_wamr_interp_classic_C"
    "esp32c6_wamr_interp_classic_Rust"
    "esp32c6_wamr_interp_fast_C"
    "esp32c6_wamr_interp_fast_Rust"
)

WAMR_SYMBOL_FILE="tmp_WAMR_symbol_file.txt"
ctags -R --languages=C,C++ --c-kinds=f --c++-kinds=f --fields=+n -o - $PROJECT_DIR/wasm-micro-runtime/core/ | cut -f1 | sort -u > $WAMR_SYMBOL_FILE


symbol_list_file=".tmp001"
symbol_elf_selected=".tmp003"

echo "Mode,WAMR Size,Wasm Application Size,Total Size"
for project in "${projects[@]}"; do
    echo -n "$project,"

    # List of WAMR symbols
    cp -f $WAMR_SYMBOL_FILE $symbol_list_file
    
    #nm -S $PROJECT_DIR/$project/build/$project.elf | awk '{print $4}' | sort -u | grep -E 'wasm|WASM|os_|_wrapper|aot|AOT|jit|JIT' >> $symbol_list_file
    # sort $symbol_list_file | uniq > .tmp002
    # mv .tmp002 $symbol_list_file && rm -f .tmp002  

    # Extract size of all symbols of WAMR from ELF file
    awk 'NR==FNR { sym[$1]; next } $4 in sym' $symbol_list_file <(nm -S $PROJECT_DIR/$project/build/$project.elf) > $symbol_elf_selected  

    # Calc the total size of WAMR from the extracted symbols
    awk '{sum += strtonum("0x" $2)} END {printf "%d,", sum}' $symbol_elf_selected

    # Get the size of Wasm application from ELF file
    # (all C and Rust Wasm/AOT are dumped to .h with variable name wasm_application_file)
    nm -S $PROJECT_DIR/$project/build/$project.elf | grep 'wasm_application_file' | awk '{printf "%d,", strtonum("0x"$2)}'

    # Remove temp file
    rm $symbol_list_file $symbol_elf_selected 

    binfile="$PROJECT_DIR/$project/build/$project.bin"
    if [ -f "$binfile" ]; then
        size=$(stat -c%s "$binfile")
        echo "$size"
    else
        echo "File $binfile does not exist."
    fi
done

rm $WAMR_SYMBOL_FILE