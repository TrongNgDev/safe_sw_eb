#!/bin/bash

report_dir="reports"

if [ ! -d "$report_dir" ]; then
  mkdir -p "$report_dir"
  echo "Created folder: $report_dir"
fi

file_1="reports/.tmp_cpu.txt"
file_report="reports/cpu_esp32c6_r9a02g021.csv"

./scripts/report_cpu_cycles_r9a02g021.sh    > "$file_1"
./scripts/report_cpu_cycles_esp32c6.sh      >> "$file_1"


# Generate csv file
echo "Name,Load,Run,Unload,Total" > "$file_report"
awk '
{
    key = $1
    sub(":", "", key)
    label = $2
    value = $3
    gsub(/\r/, "", value)

    if (label == "Load")          { load[key] = value }
    else if (label == "Run")      { run[key] = value }
    else if (label == "Unload")   { unload[key] = value }
    else if (label == "Total")    { 
        total[key] = value
        printf "%s,%s,%s,%s,%s\n", key, load[key], run[key], unload[key], total[key]
    }
}
' "$file_1" >> "$file_report"

# Remove temp file
rm -f $file_1

echo "Done!"