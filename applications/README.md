# Applications: Native (C), Wasm (from different languages), and Lua

## 1. Prerequisites
- [wasi-sdk](https://github.com/WebAssembly/wasi-sdk/releases) to compile C/C++ to Wasm, using clang
- [rust-lang](https://www.rust-lang.org/tools/install) to compile Rust to Wasm, using rustc (integrated in cargo build)
- WAMR's AoT compiler: [wamr](https://github.com/bytecodealliance/wasm-micro-runtime/tree/main/wamr-compiler). After generating the tool, move it to `tools/bin`.
- WAMR's tool: [binary-dump](https://github.com/bytecodealliance/wasm-micro-runtime/tree/main/test-tools/binarydump-tool). After generating the tool, move it to `tools/bin`.


## 2. Applications
We built image processing applications, including grayscale and brightness functions, which can pre-process images from the camera before sending them to a lite TensorFlow model for person detection or any other purpose.

Applications are written in C, Rust, and Lua.

## 3. Compilation
1. For C application: go to `image_app_c/` and run `./build_wasm.sh`. We expect the following files will be generated:
    ```
    image_app.wasm
    image_app_wasm.h
    image_app_riscv32_ilp32.aot
    image_app_riscv32_ilp32_aot.h
    image_app_x86_64_gnu.aot
    ```
2. For Rust application: go to `image_app_rust/` and run `./build_wasm.sh`. We tested with two targets, `wasm32-wasip1` and `wasm32-unknown-unknown`, and both worked fine. We expect the same file names to be generated for the C application.

    The configuration of Rust project in 2 files: `Cargo.toml` and `.cargo/config.toml`

3. For Lua application: Lua is a scripting language, so there is no compilation for interpreter mode. However, we are comparing native vs. Wasm vs. Lua, so we run `xxd` to dump the Lua to a C header and include it in the host program for a fair comparison.