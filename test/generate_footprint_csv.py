#Input: None
#Output: generate a .csv file (seperator: comma)
#
# Check and get file size of esprec6/**/build/***.bin
#  - if file not exist, output 0
# CSV format:


import os
import csv

bin_file_dirs = {
    "esp32c6_lua"                   :   "../esp32c6/esp32c6_lua/build/esp32c6_lua.bin",
    "esp32c6_native"                :   "../esp32c6/esp32c6_native/build/ESP32C6_WAMR.bin",
    "esp32c6_wamr_AOT_C"            :   "",
    "esp32c6_wamr_AOT_Rust"         :   "",
    "esp32c6_wamr_interp_classic_C" :   "../esp32c6/esp32c6_wamr_interp_classic_C/build/ESP32C6_WAMR.bin",
    "esp32c6_wamr_interp_classic_Rust": "../esp32c6/esp32c6_wamr_interp_classic_Rust/build/ESP32C6_WAMR.bin",
    "esp32c6_wamr_interp_fast_C"    :   "../esp32c6/esp32c6_wamr_interp_fast_C/build/ESP32C6_WAMR.bin",
    "esp32c6_wamr_interp_fast_Rust" :   "../esp32c6/esp32c6_wamr_interp_fast_Rust/build/ESP32C6_WAMR.bin",
}

# List to store bin file details
bin_data = []

for project, bin_path in bin_file_dirs.items():
    if not bin_path:  # Skip empty paths
        print(f"Skipping {project}: No path specified")
        continue

    # Convert relative path to absolute path
    abs_bin_path = os.path.abspath(bin_path)

    # Check if the bin file exists
    if os.path.exists(abs_bin_path) and os.path.isfile(abs_bin_path):
        file_size = os.path.getsize(abs_bin_path)  # Get file size in bytes
        bin_data.append((project, file_size))
        print(f"Project: {project}, Size: {file_size} bytes")
    else:
        print(f"Project: {project}, File: {bin_path} NOT FOUND")

# Save results to a CSV file
csv_file = "bin_file_sizes.csv"
csv_path = os.path.abspath(csv_file)

with open(csv_path, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow(["Project Name", "File Size (Bytes)"])
    writer.writerows(bin_data)

#print(f"\nResults saved to {csv_file}")

#for key, file in bin_file_dirs.items():
#    file_size = os.path.getsize(key)
#    if not os.path.exists(file):
#        print(f"Error: The file '{file}' does not exist.")
#    else:
#        abs_bin_path = os.path.abspath(bin_path)
#        print(f"ID: {key} , Dir {file}, Size{os.path.getsize(file_path)}")
