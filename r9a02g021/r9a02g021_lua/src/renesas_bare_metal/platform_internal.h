/*
 * Copyright (C) 2019 Intel Corporation.  All rights reserved.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#ifndef _PLATFORM_INTERNAL_H
#define _PLATFORM_INTERNAL_H

#include <stdint.h>
#include <stdio.h>
#include "SEGGER_RTT.h" //redirect message to RTT viewer

#ifdef __cplusplus
extern "C" {
#endif

uint32_t renesas_get_cpu_cycle(void);
int os_printf(const char *format, ...);
int os_vprintf(const char *format, va_list ap);


#ifdef __cplusplus
}
#endif

#endif //End of _PLATFORM_INTERNAL_H
