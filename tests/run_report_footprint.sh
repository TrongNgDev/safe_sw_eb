#!/bin/bash

report_dir="reports"

if [ ! -d "$report_dir" ]; then
  mkdir -p "$report_dir"
  echo "Created folder: $report_dir"
fi

./scripts/report_footprint_r9a02g021.sh   >  reports/footprint_esp32c6_r9a02g021.csv
./scripts/report_footprint_r9a02g021_lua.sh >> reports/footprint_esp32c6_r9a02g021.csv
./scripts/report_footprint_esp32c6.sh     >> reports/footprint_esp32c6_r9a02g021.csv
./scripts/report_footprint_esp32c6_lua.sh >> reports/footprint_esp32c6_r9a02g021.csv