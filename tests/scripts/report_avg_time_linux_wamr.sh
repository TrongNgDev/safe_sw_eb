#!/bin/bash

REPORT_DIR="../linux/linux_wamr/reports"

files=(
    "$REPORT_DIR/report_CI_C.txt"
    "$REPORT_DIR/report_CI_Rust.txt"
    "$REPORT_DIR/report_FI_C.txt"
    "$REPORT_DIR/report_FI_Rust.txt"
    "$REPORT_DIR/report_AOT_C.txt"
    "$REPORT_DIR/report_AOT_Rust.txt"
    "$REPORT_DIR/report_LLVMJIT_C.txt"
    "$REPORT_DIR/report_LLVMJIT_Rust.txt"
    "$REPORT_DIR/report_FJIT_C.txt"
    "$REPORT_DIR/report_FJIT_Rust.txt"
)

for file in "${files[@]}"; do
    ./scripts/get_avg_by_pattern.sh "$file" "Load*"
    ./scripts/get_avg_by_pattern.sh "$file" "Run*"
    ./scripts/get_avg_by_pattern.sh "$file" "Unload*"
    ./scripts/get_avg_by_pattern.sh "$file" "Total*"
done
