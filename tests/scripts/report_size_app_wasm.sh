#!/bin/bash

wasm_dir="../applications"

langs=(
    "c"
    "rust"
)

names=(
    "image_app.wasm"
    "image_app_wasm.h"
    "image_app_riscv32_ilp32.aot"
    "image_app_riscv32_ilp32_aot.h"
)

for lang in "${langs[@]}"; do
  for name in "${names[@]}"; do
    file="$wasm_dir/image_app_$lang/$name"
    if [ -f "$file" ]; then
      size=$(stat -c%s "$file")
      echo "$lang $name $size"
    fi
  done
done