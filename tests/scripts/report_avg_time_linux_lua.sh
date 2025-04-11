#!/bin/bash

REPORT_DIR="../linux/linux_lua/reports"

files=(
    "$REPORT_DIR/report_lua.txt"
)

for file in "${files[@]}"; do
    ./scripts/get_avg_by_pattern.sh "$file" "Load*"
    ./scripts/get_avg_by_pattern.sh "$file" "Run*"
    ./scripts/get_avg_by_pattern.sh "$file" "Unload*"
    ./scripts/get_avg_by_pattern.sh "$file" "Total*"
done
