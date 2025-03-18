# Running Wasm on ESP32C6 - Interpreter mode (Fast, Load Normal)

This project evaluate the performance of Wasm running on ESP32C6 ([ESP32-C6-DevKitC-1](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c6/esp32-c6-devkitc-1/index.html)).

Mode: Interpreter-Fast, normal loader

## Prerequisites
- ESP-IDF version 5.4.0
- wasm-micro-runtime (WAMR) v2.2.0: can be downloaded from the [WAMR website](https://github.com/bytecodealliance/wasm-micro-runtime/releases/tag/WAMR-2.2.0) or added as dependency as below.
    ```
    idf.py add-dependency "espressif/wasm-micro-runtime^2.2.0"
    ```

## Configuration
Configuration in sdkconfig: Interpreter-Fast, Normal Loader
```
# CONFIG_WAMR_ENABLE_AOT is not set
CONFIG_WAMR_ENABLE_INTERP=y
# CONFIG_WAMR_INTERP_CLASSIC is not set
CONFIG_WAMR_INTERP_FAST=y
CONFIG_WAMR_INTERP_LOADER_NORMAL=y
# CONFIG_WAMR_INTERP_LOADER_MINI is not set
CONFIG_WAMR_ENABLE_LIB_PTHREAD=y
CONFIG_WAMR_ENABLE_LIBC_BUILTIN=y
CONFIG_WAMR_ENABLE_LIBC_WASI=y
# CONFIG_WAMR_ENABLE_MEMORY_PROFILING is not set
# CONFIG_WAMR_ENABLE_MULTI_MODULE is not set
# CONFIG_WAMR_ENABLE_PERF_PROFILING is not set
# CONFIG_WAMR_ENABLE_REF_TYPES is not set
# CONFIG_WAMR_ENABLE_SHARED_MEMORY is not set
```

## Wasm application
Wasm application (.wasm) is binarydump to a C header file (.h) using ``xxd`` or the binarydump tool provided by WAMR.

After that, the Wasm file (.h) is included to the host's main program for running.

All Wasm applications for testing are stored in ``../wasm_applications/``.

## Build and Flash
```
idf.py set-target esp32c6
idf.py build
idf.py flash
idf.py monitor
```
