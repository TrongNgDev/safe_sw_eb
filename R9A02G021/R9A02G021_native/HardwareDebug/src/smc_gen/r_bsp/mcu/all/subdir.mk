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
R9A02G021_native.cref 

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
R9A02G021_native.map 


# Each subdirectory must supply rules for building sources it contributes
src/smc_gen/r_bsp/mcu/all/%.o: ../src/smc_gen/r_bsp/mcu/all/%.s
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -x assembler-with-cpp -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_bsp" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c "$<" -o "$@")
	@clang @"$@.in"
src/smc_gen/r_bsp/mcu/all/%.o: ../src/smc_gen/r_bsp/mcu/all/%.c
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -std=gnu99 -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_pincfg" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/general" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_config" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/smc_gen/r_bsp" -I"/home/tdn/safe_sw_eb/R9A02G021/R9A02G021_native/src/RTT" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" "$<" -c -o "$@")
	@clang @"$@.in"

