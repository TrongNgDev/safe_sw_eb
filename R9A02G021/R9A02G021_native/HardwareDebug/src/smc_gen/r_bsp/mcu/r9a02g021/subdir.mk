################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/smc_gen/r_bsp/mcu/r9a02g021/mcu_clocks.c \
../src/smc_gen/r_bsp/mcu/r9a02g021/mcu_mapped_interrupts.c \
../src/smc_gen/r_bsp/mcu/r9a02g021/mcu_option_settings.c 

CREF += \
R9A02G021_native.cref 

C_DEPS += \
./src/smc_gen/r_bsp/mcu/r9a02g021/mcu_clocks.d \
./src/smc_gen/r_bsp/mcu/r9a02g021/mcu_mapped_interrupts.d \
./src/smc_gen/r_bsp/mcu/r9a02g021/mcu_option_settings.d 

OBJS += \
./src/smc_gen/r_bsp/mcu/r9a02g021/mcu_clocks.o \
./src/smc_gen/r_bsp/mcu/r9a02g021/mcu_mapped_interrupts.o \
./src/smc_gen/r_bsp/mcu/r9a02g021/mcu_option_settings.o 

MAP += \
R9A02G021_native.map 


# Each subdirectory must supply rules for building sources it contributes
src/smc_gen/r_bsp/mcu/r9a02g021/%.o: ../src/smc_gen/r_bsp/mcu/r9a02g021/%.c
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -std=gnu99 -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/r_pincfg" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/general" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/r_config" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/r_bsp" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/RTT" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" "$<" -c -o "$@")
	@clang @"$@.in"

