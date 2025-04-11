#!/bin/bash

PROJECT_DIR="../r9a02g021"
project="r9a02g021_lua"

LUA_SYMBOL_FILE="tmp_WAMR_symbol_file.txt"
ctags -R --languages=C,C++ --c-kinds=f --c++-kinds=f --fields=+n -o - $PROJECT_DIR/$project/src/lua-5.4.7 | cut -f1 | sort -u > $LUA_SYMBOL_FILE


symbol_list_file=".tmp001"
symbol_elf_selected=".tmp003"


echo "Mode,Lua runtime Size,Lua Application Size,Total Size"
echo -n "$project,"

# List of WAMR symbols
cp -f $LUA_SYMBOL_FILE $symbol_list_file

#nm -S $PROJECT_DIR/$project/build/$project.elf | awk '{print $4}' | sort -u | grep -E 'wasm|WASM|os_|_wrapper|aot|AOT|jit|JIT' >> $symbol_list_file
# sort $symbol_list_file | uniq > .tmp002
# mv .tmp002 $symbol_list_file && rm -f .tmp002  

# Extract size of all symbols of WAMR from ELF file
awk 'NR==FNR { sym[$1]; next } $4 in sym' $symbol_list_file <(nm -S $PROJECT_DIR/$project/HardwareDebug/$project.elf) > $symbol_elf_selected  

# Calc the total size of WAMR from the extracted symbols
awk '{sum += strtonum("0x" $2)} END {printf "%d,", sum}' $symbol_elf_selected

# Get the size of Lua application from ELF file
nm -S $PROJECT_DIR/$project/HardwareDebug/$project.elf | grep 'image_app_lua' | grep -v 'image_app_lua_len' | awk '{printf "%d,", strtonum("0x"$2)}'

# Remove temp file
rm $symbol_list_file $symbol_elf_selected 

binfile="$PROJECT_DIR/$project/HardwareDebug/$project.bin"
if [ -f "$binfile" ]; then
    size=$(stat -c%s "$binfile")
    echo "$size"
else
    echo "File $binfile does not exist."
fi


rm $LUA_SYMBOL_FILE