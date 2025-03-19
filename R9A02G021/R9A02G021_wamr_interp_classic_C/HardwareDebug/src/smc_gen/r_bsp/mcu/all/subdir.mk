################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../src/smc_gen/r_bsp/mcu/all/exit.s \
../src/smc_gen/r_bsp/mcu/all/machine_timer_aux.s \
../src/smc_gen/r_bsp/mcu/all/r_bsp_common_llvm.s \
../src/smc_gen/r_bsp/mcu/all/start.s 

C_SRCS += \
../src/smc_gen/r_bsp/mcu/all/r_bsp_common.c \
../src/smc_gen/r_bsp/mcu/all/r_bsp_machine_timer.c 

S_DEPS += \
./src/smc_gen/r_bsp/mcu/all/exit.d \
./src/smc_gen/r_bsp/mcu/all/machine_timer_aux.d \
./src/smc_gen/r_bsp/mcu/all/r_bsp_common_llvm.d \
./src/smc_gen/r_bsp/mcu/all/start.d 

CREF += \
R9A02G021_wamr_interp_classic_C.cref 

C_DEPS += \
./src/smc_gen/r_bsp/mcu/all/r_bsp_common.d \
./src/smc_gen/r_bsp/mcu/all/r_bsp_machine_timer.d 

OBJS += \
./src/smc_gen/r_bsp/mcu/all/exit.o \
./src/smc_gen/r_bsp/mcu/all/machine_timer_aux.o \
./src/smc_gen/r_bsp/mcu/all/r_bsp_common.o \
./src/smc_gen/r_bsp/mcu/all/r_bsp_common_llvm.o \
./src/smc_gen/r_bsp/mcu/all/r_bsp_machine_timer.o \
./src/smc_gen/r_bsp/mcu/all/start.o 

MAP += \
R9A02G021_wamr_interp_classic_C.map 


# Each subdirectory must supply rules for building sources it contributes
src/smc_gen/r_bsp/mcu/all/%.o: ../src/smc_gen/r_bsp/mcu/all/%.s
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -x assembler-with-cpp -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_bsp" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/common/arch" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c "$<" -o "$@")
	@clang @"$@.in"
src/smc_gen/r_bsp/mcu/all/%.o: ../src/smc_gen/r_bsp/mcu/all/%.c
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -std=gnu99 -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_bsp" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/mem-alloc/ems" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/include" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/libraries/libc-builtin" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/common" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/utils" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/platform/include" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/common/arch" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/interpreter" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/mem-alloc" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/libraries" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/platform" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/shared/platform/renesasriscv" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" "$<" -c -o "$@")
	@clang @"$@.in"

