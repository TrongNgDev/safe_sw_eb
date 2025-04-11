
# ESP-IDF ESP32C6 projects
This part evaluates the feasibility of applying Wasm to ESP32C6 board as well as its performance.

Regarding Lua on ESP32C6, refer to [README_Lua](README_Lua.md).

## 1. Hardware
- [ESP32-C6-DevKitC-1](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c6/esp32-c6-devkitc-1/index.html)


## 2. Prerequisites
- ESP-IDF version 5.4
- WebAssembly Mirco Runtime (WAMR) v2.2.0: prepared as a git submodule under esp32c6/wasm-micro-runtime. 

    However, it can also be downloaded from the [WAMR-2.2.0 Release](https://github.com/bytecodealliance/wasm-micro-runtime/releases/tag/WAMR-2.2.0) or added as dependency as below.
    ```
    idf.py add-dependency "espressif/wasm-micro-runtime^2.2.0"
    ```

## 3. Project Configuration
Project configuration for each mode is defauted in `sdkconfig.defaults`.

Note: The AoT compilation mode require executable RAM, but it's not available in ESP32C6. There are 2 approaches to fix this:

1. Disable `CONFIG_ESP_SYSTEM_PMP_IDRAM_SPLIT`, so Data RAM is also executable (work-around solution, not safe).
2. Modify firmware to reserver a part of RAM as IRAM (stable solution).

In this project, we apply solution 1 to check if WAMR AoT mode can run successfully or not.

## 4. Wasm application
Wasm applications are placed at `../applications/image_app_C/` and `../applications/image_app_Rust/`.

## 5. How to run
Connect the ESP32C6 board to PC, then go to `esp32c6_warm*/` and invoke the script
```./build_and_run.sh```. The content of this script is as below.
```
idf.py set-target esp32c6
idf.py build
idf.py flash
idf.py monitor
```

There are three execution modes being tested with Wasm application compiled from C and Rust. The normal loader is used instead of mini loader.
```
Classic Interpreter
Fast Interpreter
AoT Compilation
```
