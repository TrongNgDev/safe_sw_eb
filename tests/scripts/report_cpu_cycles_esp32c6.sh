#!/bin/bash

REPORT_DIR="../esp32c6"

files=(
    "$REPORT_DIR/esp32c6_lua/monitor.log"
    "$REPORT_DIR/esp32c6_native/monitor.log"
    "$REPORT_DIR/esp32c6_wamr_interp_classic_C/monitor.log"
    "$REPORT_DIR/esp32c6_wamr_interp_classic_Rust/monitor.log"
    "$REPORT_DIR/esp32c6_wamr_interp_fast_C/monitor.log"
    "$REPORT_DIR/esp32c6_wamr_interp_fast_Rust/monitor.log"
    "$REPORT_DIR/esp32c6_wamr_AOT_C/monitor.log"
    "$REPORT_DIR/esp32c6_wamr_AOT_Rust/monitor.log"
)

pattern="ESP32C6_*"
for file in "${files[@]}"; do
    while read -r line; do
        if [[ $line == $pattern ]]; then
            echo -e "$line"
        fi
    done < "$file"
done
