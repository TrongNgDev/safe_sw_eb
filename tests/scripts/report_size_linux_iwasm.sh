#!/bin/bash

REPORT_DIR="../linux/linux_wamr/WAMR"

files=(
    "$REPORT_DIR/iwasm_ci"
    "$REPORT_DIR/iwasm_fi"
    "$REPORT_DIR/iwasm_aot"
    "$REPORT_DIR/iwasm_llvm_jit"
    "$REPORT_DIR/iwasm_fast_jit"
)


for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file")
        filename=$(basename "$file")
        echo -e "$filename $size"
    else
        echo "File $file does not exist."
    fi
done
