/*
 * Copyright (C) 2019-21 Intel Corporation and others.  All rights reserved.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#include <stdio.h>
#include <pthread.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_cpu.h"
#include "esp_log.h"
#include "image_app.h"

#define NATIVE_MAIN_STACK_SIZE 5120
#define CPU_CYCLE_ENABLE 1
#define LOG_ENALBE 0
#define LOG_TAG "native"

size_t cpu_cycle_app_start = 0;
size_t cpu_cycle_app_end = 0;

void *
native_main(void *arg)
{
    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_app_start = esp_cpu_get_cycle_count();
    #endif

    #if LOG_ENALBE == 1
        ESP_LOGI(LOG_TAG, "Running native app");
    #endif
    image_app_main();
    
    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_app_end = esp_cpu_get_cycle_count();
    #endif

    return NULL;
}

void
app_main(void)
{
    pthread_t t;
    int res;

    pthread_attr_t tattr;
    pthread_attr_init(&tattr);
    pthread_attr_setdetachstate(&tattr, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setstacksize(&tattr, NATIVE_MAIN_STACK_SIZE);

    res = pthread_create(&t, &tattr, native_main, (void *)NULL);
    assert(res == 0);

    res = pthread_join(t, NULL);
    assert(res == 0);
    
    #if CPU_CYCLE_ENABLE == 1
        printf("Native: cpu cycles - load WAMR:    0\n");
        printf("Native: cpu cycles - run Wasm app: %d\n", cpu_cycle_app_end - cpu_cycle_app_start);
        printf("Native: cpu cycles - unload WAMR:  0\n");
        printf("Native: cpu cycles - total:        %d\n", cpu_cycle_app_end - cpu_cycle_app_start);
    #endif

    ESP_LOGI(LOG_TAG, "Exiting...");
}
