# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/tdn/esp/v5.4/esp-idf/components/bootloader/subproject"
  "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader"
  "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix"
  "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix/tmp"
  "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix/src/bootloader-stamp"
  "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix/src"
  "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix/src/bootloader-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix/src/bootloader-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/tdn/safe_sw_eb/esp32c6/esp32c6_wamr_interp_classic_C/build/bootloader-prefix/src/bootloader-stamp${cfgdir}") # cfgdir has leading slash
endif()
