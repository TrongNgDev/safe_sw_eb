################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/wasm-micro-runtime/core/iwasm/common/arch/invokeNative_riscv.S 

CREF += \
R9A02G021_wamr_interp_classic_C.cref 

OBJS += \
./src/wasm-micro-runtime/core/iwasm/common/arch/invokeNative_riscv.o 

MAP += \
R9A02G021_wamr_interp_classic_C.map 

S_UPPER_DEPS += \
./src/wasm-micro-runtime/core/iwasm/common/arch/invokeNative_riscv.d 


# Each subdirectory must supply rules for building sources it contributes
src/wasm-micro-runtime/core/iwasm/common/arch/%.o: ../src/wasm-micro-runtime/core/iwasm/common/arch/%.S
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -x assembler-with-cpp -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_bsp" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_wamr_interp_classic_C/src/wasm-micro-runtime/core/iwasm/common/arch" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c "$<" -o "$@")
	@clang @"$@.in"

