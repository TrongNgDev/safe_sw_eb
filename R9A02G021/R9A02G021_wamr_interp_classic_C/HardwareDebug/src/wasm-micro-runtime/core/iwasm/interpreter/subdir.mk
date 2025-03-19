################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/wasm-micro-runtime/core/iwasm/interpreter/wasm_interp_classic.c \
../src/wasm-micro-runtime/core/iwasm/interpreter/wasm_loader.c \
../src/wasm-micro-runtime/core/iwasm/interpreter/wasm_runtime.c 

CREF += \
R9A02G021_wamr_interp_classic_C.cref 

C_DEPS += \
./src/wasm-micro-runtime/core/iwasm/interpreter/wasm_interp_classic.d \
./src/wasm-micro-runtime/core/iwasm/interpreter/wasm_loader.d \
./src/wasm-micro-runtime/core/iwasm/interpreter/wasm_runtime.d 

OBJS += \
./src/wasm-micro-runtime/core/iwasm/interpreter/wasm_interp_classic.o \
./src/wasm-micro-runtime/core/iwasm/interpreter/wasm_loader.o \
./src/wasm-micro-runtime/core/iwasm/interpreter/wasm_runtime.o 

MAP += \
R9A02G021_wamr_interp_classic_C.map 


# Each subdirectory must supply rules for building sources it contributes
src/wasm-micro-runtime/core/iwasm/interpreter/%.o: ../src/wasm-micro-runtime/core/iwasm/interpreter/%.c
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -std=gnu99 -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_bsp" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/mem-alloc/ems" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/include" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/libraries/libc-builtin" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/common" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/utils" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/platform/include" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/common/arch" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/interpreter" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/mem-alloc" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/libraries" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/platform" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/platform/renesasriscv" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" "$<" -c -o "$@")
	@clang @"$@.in"

