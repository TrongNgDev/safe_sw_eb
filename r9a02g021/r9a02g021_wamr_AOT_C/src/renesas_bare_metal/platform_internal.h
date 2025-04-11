/*
 * Copyright (C) 2019 Intel Corporation.  All rights reserved.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#ifndef _PLATFORM_INTERNAL_H
#define _PLATFORM_INTERNAL_H

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

#include "SEGGER_RTT.h" //redirect message to RTT viewer

#ifdef __cplusplus
extern "C" {
#endif

#ifndef BH_PLATFORM_RENESAS_BARE_METAL
#define BH_PLATFORM_RENESAS_BARE_METAL
#endif

/* Turn on to check what function is called but not implemented for WAMR*/
#ifndef BH_RENESAS_DEBUG
#define BH_RENESAS_DEBUG 0
#endif

/* Not used, just define here to make the compiler happy */
typedef pthread_t korp_tid;
typedef pthread_mutex_t korp_mutex;
typedef pthread_cond_t korp_cond;
typedef pthread_t korp_thread;
typedef struct {
    int dummy;
} korp_rwlock;
typedef unsigned int korp_sem;

/* Below parts of d_type define are ported from Nuttx, under Apache License v2.0
 */
static inline int
os_getpagesize()
{
    //return 4096;
	return 1024;
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

/**
 * Note: the following are for internal use, not in WAMR
 * Make sure heap_t and block_t are aligned with 8 bytes
 */
typedef struct heap_t {
    struct block_t *free;
    struct block_t *used;
    uint32_t free_size;
    uint32_t used_size;
} heap_t;

typedef struct block_t {
	void *addr;				//address of data area in block
	struct block_t *next;	//next block
    uint32_t size; 			//data size
    uint32_t filler;
} block_t;

static heap_t *heap_eccram = NULL;
static heap_t *heap_ram = NULL;

#define RENESAS_BLOCK_SIZE_MIN	(sizeof(block_t) + 8)

uint32_t renesas_get_cpu_cycle(void);
void renesas_heap_init_eccram(void);
void renesas_heap_init_ram(void);
void renesas_heap_print_info(void);


#ifdef __cplusplus
}
#endif

#endif //End of _PLATFORM_INTERNAL_H
