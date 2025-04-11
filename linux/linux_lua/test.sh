#!/bin/sh

loop_count=1000

report_dir="reports"

if [ ! -d "$report_dir" ]; then
  mkdir -p "$report_dir"
  echo "Created folder: $report_dir"
fi

echo "Test lua on linux.."
rm -f "$report_dir"/report_lua.txt
for i in $(seq 1 $loop_count); do
  ./lua-5.4.7/lua ../../applications/image_app_lua/image_app.lua >> "$report_dir"/report_lua.txt
done

echo "\nDone!"
