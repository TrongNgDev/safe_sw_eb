################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/smc_gen/general/r_cg_inthandler.c \
../src/smc_gen/general/r_cg_systeminit.c \
../src/smc_gen/general/r_cg_vect_table.c \
../src/smc_gen/general/r_smc_cgc.c \
../src/smc_gen/general/r_smc_cgc_user.c \
../src/smc_gen/general/r_smc_interrupt.c 

CREF += \
R9A02G021_native.cref 

C_DEPS += \
./src/smc_gen/general/r_cg_inthandler.d \
./src/smc_gen/general/r_cg_systeminit.d \
./src/smc_gen/general/r_cg_vect_table.d \
./src/smc_gen/general/r_smc_cgc.d \
./src/smc_gen/general/r_smc_cgc_user.d \
./src/smc_gen/general/r_smc_interrupt.d 

OBJS += \
./src/smc_gen/general/r_cg_inthandler.o \
./src/smc_gen/general/r_cg_systeminit.o \
./src/smc_gen/general/r_cg_vect_table.o \
./src/smc_gen/general/r_smc_cgc.o \
./src/smc_gen/general/r_smc_cgc_user.o \
./src/smc_gen/general/r_smc_interrupt.o 

MAP += \
R9A02G021_native.map 


# Each subdirectory must supply rules for building sources it contributes
src/smc_gen/general/%.o: ../src/smc_gen/general/%.c
	@echo 'Building file: $<'
	$(file > $@.in,--target=riscv32 -mabi=ilp32 -march=rv32imaczba_zbb_zbs -Oz -ffunction-sections -fdata-sections -flto -fdiagnostics-parseable-fixits -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Waggregate-return -g -std=gnu99 -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/r_pincfg" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/general" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/r_config" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/smc_gen/r_bsp" -I"/home/tdn/safe-sw-eb/R9A02G021_native/src/RTT" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" "$<" -c -o "$@")
	@clang @"$@.in"

