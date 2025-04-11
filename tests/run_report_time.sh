#!/bin/bash

report_dir="reports"

if [ ! -d "$report_dir" ]; then
  mkdir -p "$report_dir"
  echo "Created folder: $report_dir"
fi

file_1="reports/.tmp_cpu_wamr_linux.txt"
file_report_wamr="reports/time_avg_wamr_linux.csv"

# Calculate the average time
./scripts/report_avg_time_linux_wamr.sh > "$file_1"

# Generate csv file
echo "Name,Load,Run,Unload,Total" > "$file_report_wamr"
awk '
{
    key = $1
    sub(":", "", key)
    label = $2
    value = $3

    if (label == "Load")          { load[key] = value }
    else if (label == "Run")      { run[key] = value }
    else if (label == "Unload")   { unload[key] = value }
    else if (label == "Total")    { 
        total[key] = value
        printf "%s,%s,%s,%s,%s\n", key, load[key], run[key], unload[key], total[key]
    }
}
' "$file_1" >> "$file_report_wamr"

# Remove temp file
rm -f $file_1

#============================================================#
file_3="reports/.tmp_cpu_lua_linux.txt"
file_report_lua="reports/time_avg_lua_linux.csv"

# Calculate the average time
./scripts/report_avg_time_linux_lua.sh  > "$file_3"

# Generate csv file
echo "Name,Load,Run,Unload,Total" > "$file_report_lua"
awk '
{
    key = $1
    sub(":", "", key)
    label = $2
    value = $3

    if (label == "Load")          { load[key] = value }
    else if (label == "Run")      { run[key] = value }
    else if (label == "Unload")   { unload[key] = value }
    else if (label == "Total")    { 
        total[key] = value
        printf "%s,%s,%s,%s,%s\n", key, load[key], run[key], unload[key], total[key]
    }
}
' "$file_3" >> "$file_report_lua"

# Remove temp file
rm -f $file_3

echo "Done!"