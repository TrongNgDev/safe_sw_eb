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

#if CPU_CYCLE_ENABLE == 1
size_t cpu_cycle_start = 0;
size_t cpu_cycle_app_start = 0;
size_t cpu_cycle_app_end = 0;
size_t cpu_cycle_end = 0;
#endif 

void *
native_main(void *arg)
{
#if CPU_CYCLE_ENABLE == 1
    cpu_cycle_start = esp_cpu_get_cycle_count();
#endif

#if LOG_ENALBE == 1
    ESP_LOGI(LOG_TAG, "Running native app");
#endif

image_app_main();
    
#if CPU_CYCLE_ENABLE == 1
    cpu_cycle_end = esp_cpu_get_cycle_count();
#endif

    return NULL;
}

void
app_main(void)
{
    ESP_LOGI(LOG_TAG, "Starting running Native app ...");
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
    printf("ESP32C6_Native: Load   0\n");
    printf("ESP32C6_Native: Run    %d\n", cpu_cycle_end - cpu_cycle_start);
    printf("ESP32C6_Native: Unload 0\n");
    printf("ESP32C6_Native: Total  %d\n", cpu_cycle_end - cpu_cycle_start);
#endif
    ESP_LOGI(LOG_TAG, "Exiting...");
}
