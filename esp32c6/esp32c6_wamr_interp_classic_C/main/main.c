/*
* Copyright (C) 2019-21 Intel Corporation and others.  All rights reserved.
* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
*/

#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_cpu.h"
#include "esp_log.h"

// Wasm runtime (WAMR)
#include "wasm_export.h"
#include "bh_platform.h"

// Wasm application
#include "../../applications/image_app_c/image_app_wasm.h"

#define IWASM_MAIN_STACK_SIZE 5120
#define CPU_CYCLE_ENABLE 1
#define LOG_ENABLE 0
#define LOG_TAG "wamr"

size_t cpu_cycle_start = 0;
size_t cpu_cycle_end = 0;
size_t cpu_cycle_app_start = 0;
size_t cpu_cycle_app_end = 0;


static void *
app_instance_main(wasm_module_inst_t module_inst)
{
    const char *exception;
    wasm_application_execute_main(module_inst, 0, NULL);
    if ((exception = wasm_runtime_get_exception(module_inst)))
        ESP_LOGE(LOG_TAG, "%s", exception);
    return NULL;
}


void *
iwasm_main(void *arg)
{
    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_start = esp_cpu_get_cycle_count();
    #endif

    wasm_module_t wasm_module = NULL;
    wasm_module_inst_t wasm_module_inst = NULL;
    char error_buf[128];
    void *ret;
    
    // Configure memory allocation
    RuntimeInitArgs init_args;
    memset(&init_args, 0, sizeof(RuntimeInitArgs));
    init_args.mem_alloc_type = Alloc_With_Allocator;
    init_args.mem_alloc_option.allocator.malloc_func = (void *)os_malloc;
    init_args.mem_alloc_option.allocator.realloc_func = (void *)os_realloc;
    init_args.mem_alloc_option.allocator.free_func = (void *)os_free;
    
    // Stack and Heap size (adjusted for each Wasm application)
    uint32_t default_stack_size = 4*1024;
    uint32_t host_managed_heap_size = 4*1024;

    // Wasm application
    uint8_t *wasm_file_buf = (uint8_t *)wasm_application_file;
    unsigned wasm_file_buf_size = sizeof(wasm_application_file);

    // Initialize Wasm runtime: Full init
    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Initialize Wasm runtime");
    #endif
    if (!wasm_runtime_full_init(&init_args)) 
    {
        ESP_LOGE(LOG_TAG, "Init runtime failed.");
        return NULL;
    }

    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Run WAMR with interpreter");
    #endif

    // Load Wasm module
    if (!(wasm_module = wasm_runtime_load(wasm_file_buf, wasm_file_buf_size, error_buf, sizeof(error_buf)))) 
    {
        ESP_LOGE(LOG_TAG, "Error in wasm_runtime_load: %s", error_buf);
        goto fail1interp;
    }

    // Instantiate Wasm runtime
    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Instantiate Wasm runtime");
    #endif
    if (!(wasm_module_inst = wasm_runtime_instantiate(wasm_module,
            default_stack_size, host_managed_heap_size, error_buf, sizeof(error_buf))))
    {
        ESP_LOGE(LOG_TAG, "Error while instantiating: %s", error_buf);
        goto fail2interp;
    }

    // Run Wasm application
    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Run main() of the application");
    #endif
    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_app_start = esp_cpu_get_cycle_count();
    #endif
    ret = app_instance_main(wasm_module_inst);
    assert(!ret);
    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_app_end = esp_cpu_get_cycle_count();
    #endif

    // Destroy the module instance
    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Deinstantiate WASM runtime");
    #endif
    wasm_runtime_deinstantiate(wasm_module_inst);

fail2interp:
    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Unload WASM module");
    #endif
    wasm_runtime_unload(wasm_module);

fail1interp:
    #if LOG_ENABLE == 1
        ESP_LOGI(LOG_TAG, "Destroy WASM runtime");
    #endif
    wasm_runtime_destroy();

    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_end = esp_cpu_get_cycle_count();
    #endif
    return NULL;
}

void
app_main(void)
{
    ESP_LOGI(LOG_TAG, "Starting running Wasm app (from C) on WAMR - classic interpreter...");
    pthread_t t;
    int res;

    pthread_attr_t tattr;
    pthread_attr_init(&tattr);
    pthread_attr_setdetachstate(&tattr, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setstacksize(&tattr, IWASM_MAIN_STACK_SIZE);

    res = pthread_create(&t, &tattr, iwasm_main, (void *)NULL);
    assert(res == 0);

    res = pthread_join(t, NULL);
    assert(res == 0);

#if CPU_CYCLE_ENABLE == 1
    size_t cpu_cycle_load = cpu_cycle_app_start - cpu_cycle_start;
    size_t cpu_cycle_app = cpu_cycle_app_end - cpu_cycle_app_start;
    size_t cpu_cycle_unload = cpu_cycle_end - cpu_cycle_app_end;   
    printf("WAMR: cpu cycles - load WAMR:    %d\n", cpu_cycle_load);
    printf("WAMR: cpu cycles - run Wasm app: %d\n", cpu_cycle_app);
    printf("WAMR: cpu cycles - unload WAMR:  %d\n", cpu_cycle_unload);
    printf("WAMR: cpu cycles - total:        %d\n", cpu_cycle_load + cpu_cycle_app + cpu_cycle_unload);
#endif

    ESP_LOGI(LOG_TAG, "Exiting...");
}
