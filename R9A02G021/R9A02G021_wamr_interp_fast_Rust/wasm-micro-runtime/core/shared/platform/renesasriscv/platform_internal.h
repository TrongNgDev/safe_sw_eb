/*
 * Copyright (C) 2019 Intel Corporation.  All rights reserved.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#ifndef _PLATFORM_INTERNAL_H
#define _PLATFORM_INTERNAL_H

//==============================================================================
#include "SEGGER_RTT.h"
#include <stdbool.h>
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <pthread.h>
#include <unistd.h>
//#include <sys/types.h>
//#include <sys/stat.h>
//#include <sys/timeb.h>
//#include <sys/resource.h>
//#include <sys/cdefs.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef pthread_t korp_tid;
typedef pthread_mutex_t korp_mutex;
typedef pthread_cond_t korp_cond;
typedef pthread_t korp_thread;
//typedef pthread_rwlock_t korp_rwlock;
typedef pthread_once_t korp_rwlock;
typedef unsigned int korp_sem;


#define BH_APPLET_PRESERVED_STACK_SIZE (2 * BH_KB)

/* Default thread priority */
#define BH_THREAD_DEFAULT_PRIORITY 5

/* Special value for tv_nsec field of timespec */

#define UTIME_NOW ((1l << 30) - 1l)
#ifndef __cplusplus
#define UTIME_OMIT ((1l << 30) - 2l)
#endif


/* Below parts of d_type define are ported from Nuttx, under Apache License v2.0
 */
static inline int
os_getpagesize()
{
    //return 4096;
	return 2048;
}
/* The below types are used in platform_api_extension.h,
   we just define them to make the compiler happy */
typedef int os_file_handle;
typedef void *os_dir_stream;
typedef int os_raw_file_handle;


static inline os_file_handle
os_get_invalid_handle(void)
{
    return -1;
}

#ifdef __cplusplus
}
#endif

#endif //End of _PLATFORM_INTERNAL_H
