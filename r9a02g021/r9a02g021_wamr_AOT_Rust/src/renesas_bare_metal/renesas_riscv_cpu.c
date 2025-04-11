#include "platform_internal.h"

#define RV_READ_CSR(reg) ({ unsigned long __tmp; asm volatile ("csrr %0, " #reg : "=r"(__tmp)); __tmp; })

uint32_t
renesas_get_cpu_cycle (void)
{
	return RV_READ_CSR(mcycle);
}
