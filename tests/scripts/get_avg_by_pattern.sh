#!/bin/bash

# Check syntax
if [[ $# -ne 2 ]]; then
    echo "Get average cpu cycles by pattern."
    echo "Usage: $0 <log_file> $1 <pattern>"
    exit 1
fi

#
log_file="$1"
pattern="$2"

# Check if file exists
if [[ ! -f "$log_file" ]]; then
    echo "Error: File '$log_file' not found!"
    exit 1
fi

# Extract "Load" values, sum them, and count the lines
sum=0
count=0
while read -r line; do
    if [[ $line == $pattern ]]; then
        number=$(echo $line | awk '{print $2}')
        sum=$((sum + number))
        count=$((count + 1))
    fi
done < "$log_file"

# Calculate average
if [[ $count -gt 0 ]]; then
    avg=$((sum / count))
    filename=$(basename "$log_file")
    running_mode=$(echo "$filename" | sed -E 's/^report_(.*)\.txt$/\1/')
    pattern_mod=$(echo "$pattern" | sed 's/\*$//')
    echo -e "Linux_WAMR_$running_mode: $pattern_mod $avg"
else
    echo "No $pattern entries found."
fi