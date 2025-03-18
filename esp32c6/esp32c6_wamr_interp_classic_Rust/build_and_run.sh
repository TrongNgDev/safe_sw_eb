#!/bin/bash -e

if [ -z "$IDF_PATH" ]; then
  echo "Error: IDF_PATH is not set. Please source the file \$IDF_PATH/export.sh and try again."
  echo "Example: '. $HOME/esp/v5.4/esp-idf/export.sh'"
  exit 1
fi

rm -rf build
idf.py set-target "esp32c6"
idf.py build
idf.py flash
#idf.py monitor
