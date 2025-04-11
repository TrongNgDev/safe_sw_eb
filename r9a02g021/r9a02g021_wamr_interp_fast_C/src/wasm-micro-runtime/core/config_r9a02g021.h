/*
* Some specific configuration for running WAMR on R9A02G021 Renesas RISCV board
*/

#ifndef _CONFIG_R9A02G021_H_
#define _CONFIG_R9A02G021_H_

#ifndef BUILD_TARGET_RISCV32_ILP32
#define BUILD_TARGET_RISCV32_ILP32
#endif

#ifndef BH_MALLOC
#define BH_MALLOC wasm_runtime_malloc
#endif

#ifndef BH_FREE
#define BH_FREE wasm_runtime_free
#endif

/* Enable Interpreter modes or not */
#ifndef WASM_ENABLE_INTERP
#define WASM_ENABLE_INTERP 1
#endif
#ifndef WASM_ENABLE_FAST_INTERP
#define WASM_ENABLE_FAST_INTERP 1
#endif

/* Enable AoT modes or not */
#ifndef WASM_ENABLE_AOT
#define WASM_ENABLE_AOT 0
#endif

/* Enable JIT modes or not */
#ifndef WASM_ENABLE_JIT
#define WASM_ENABLE_JIT 0
#endif
#ifndef WASM_ENABLE_LAZY_JIT
#define WASM_ENABLE_LAZY_JIT 0
#endif
#ifndef WASM_ENABLE_FAST_JIT
#define WASM_ENABLE_FAST_JIT 0
#endif

/* Enable wasm mini loader or not */
#ifndef WASM_ENABLE_MINI_LOADER
#define WASM_ENABLE_MINI_LOADER 0
#endif

#ifndef WASM_ENABLE_LIBC_BUILTIN
#define WASM_ENABLE_LIBC_BUILTIN 1
#endif

#ifndef WASM_ENABLE_REF_TYPES
#define WASM_ENABLE_REF_TYPES 1
#endif

/* Turn off some AoT flags that accidently impact the Interpreter mode */
#ifndef WASM_ENABLE_AOT_INTRINSICS
#define WASM_ENABLE_AOT_INTRINSICS 0
#endif

#ifndef WASM_ENABLE_QUICK_AOT_ENTRY
#define WASM_ENABLE_QUICK_AOT_ENTRY 0
#endif

#endif
