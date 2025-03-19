################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/smc_gen/r_bsp/board/generic_r9a02g021/hdwinit.c \
../src/smc_gen/r_bsp/board/generic_r9a02g021/r_bsp_init.c 

CREF += \
R9A02G021_native.cref 

C_DEPS += \
./src/smc_gen/r_bsp/board/generic_r9a02g021/hdwinit.d \
./src/smc_gen/r_bsp/board/generic_r9a02g021/r_bsp_init.d 

OBJS += \
./src/smc_gen/r_bsp/board/generic_r9a02g021/hdwinit.o \
./src/smc_gen/r_bsp/board/generic_r9a02g021/r_bsp_init.o 

MAP += \
R9A02G021_native.map 


# Each subdirectory must supply rules for building sources it contributes
src/smc_gen/r_bsp/board/generic_r9a02g021/%.o: ../src/smc_gen/r_bsp/board/generic_r9a02g021/%.c
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -std=gnu99 -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_bsp" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/RTT" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" "$<" -c -o "$@")
	@clang @"$@.in"

