# Memory-safe software for embedded systems
This project evaluates the feasibility of applying memory-safe software to embedded system.

In this project, we implemented and evaluated 2 memory-safe languages, including WebAssembly (Wasm) and Lua in 2 different platforms: ESP32C6 (FreeRTOS) and Renesas R9A02G021 (bare-metal).

## 1. Project structure
- `esp32c6/`  : [Wasm](esp32c6/README.md) and [Lua](esp32c6/README_Lua.md)  on ESP32C6.
- `r9a02g021/`: [Wasm and Lua on R9A02G021](r9a02g021/README.md)
- `linux/`: some test on linux
- `applications/`: [Wasm/Lua applications](applications/README.md)
- `tools/` : [some tools](tools/README.md) used in this project

## 2. How to run
1. Clone recursive the git repo
    ```
    git clone --recursive https://github.com/TrongNgDev/safe_sw_eb.git
    ```
2. Install required software
    - Build required WAMR tools: [binarydump and wamrc](tools/README.md)
    - Install [required software](applications/README.md) to compile C/Rust to Wasm

3. Build Wasm application: go to `applications/` and run build script to compile C/Rust code to Wasm.

4. To test on ESP32C6 board, go to `esp32c6/` and follow [the guide](esp32c6/README.md).

5. To test on R9A02G021 board, go to `r9a02g021/` and follow [the guide](esp32c6/README.md).

6. We also perform a test on Linux and compare with the test on the 2 platforms. But this buid just for our comparison only.

    If you want to run a Wasm application on your PC, you can download the appropriate `iwasm` from the [WAMR Release 2.2.0](https://github.com/bytecodealliance/wasm-micro-runtime/releases/tag/WAMR-2.2.0).

## 3. Results
Overall, both Wasm and Lua can be applied to embedded systems, but Wasm is a better choice: it has a smaller code footprint, is faster, and supports a sandbox environment by default.

The Wasm AoT compilation mode can reach near-native speed (1.4-3.5x slower in our test) and faster than the Interpreter modes (4-86x faster in our test).

The Wasm fast interpreter is faster >2x the classic interpreter, but it takes more time to load/start the environment.
