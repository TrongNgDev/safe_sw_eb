#!/bin/bash

file="../r9a02g021/terminal.log"

grep "Renesas_" "$file" | awk '{$1=""; sub(/^ /, ""); print}'
