/*
 * SPDX-FileCopyrightText: 2010-2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: CC0-1.0
 */

#include <stdio.h>
#include <pthread.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_cpu.h"
#include "esp_log.h"

// Lua runtime
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

// Lua application
#include "../../../applications/image_app_lua/image_app_lua.h"

#define LUA_MAIN_STACK_SIZE 5120
#define CPU_CYCLE_ENABLE 1
#define LOG_ENABLE 0
#define LOG_TAG "Lua"

#if CPU_CYCLE_ENABLE == 1
size_t cpu_cycle_start = 0;
size_t cpu_cycle_end = 0;
size_t cpu_cycle_app_start = 0;
size_t cpu_cycle_app_end = 0;
#endif

void *
run_embedded_lua(void *arg)
{
#if CPU_CYCLE_ENABLE == 1
    cpu_cycle_start = esp_cpu_get_cycle_count();
#endif

    const char *lua_script = (const char*)image_app_lua;
    size_t lua_script_len = (size_t)image_app_lua_len;

    lua_State *L = luaL_newstate();
    if (L == NULL)
    {
        ESP_LOGE(LOG_TAG,"Failed to create new Lua state");
        return NULL;
    }

    luaL_openlibs(L);
    if (luaL_loadbuffer(L, lua_script, lua_script_len, "lua_script") != LUA_OK)
    {
        ESP_LOGE(LOG_TAG,"Error loading Lua script: %s", lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_close(L);
        return NULL;
    }

#if CPU_CYCLE_ENABLE == 1
    cpu_cycle_app_start = esp_cpu_get_cycle_count();
#endif
    if (lua_pcall(L, 0, LUA_MULTRET, 0) != LUA_OK)
    {
        ESP_LOGE(LOG_TAG,"Error running Lua script: %s", lua_tostring(L, -1));
        lua_pop(L, 1);
    }
#if CPU_CYCLE_ENABLE == 1
    cpu_cycle_app_end = esp_cpu_get_cycle_count();
#endif

    lua_close(L);
    
#if CPU_CYCLE_ENABLE == 1
    cpu_cycle_end = esp_cpu_get_cycle_count();
#endif
    return NULL;
}
 

void
app_main(void)
{
    ESP_LOGI(LOG_TAG, "Starting running Lua app ...");

    pthread_t t;
    int res;
    pthread_attr_t tattr;
    pthread_attr_init(&tattr);
    pthread_attr_setdetachstate(&tattr, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setstacksize(&tattr, LUA_MAIN_STACK_SIZE);

    res = pthread_create(&t, &tattr, run_embedded_lua, (void *)NULL);
    assert(res == 0);

    res = pthread_join(t, NULL);
    assert(res == 0);

#if CPU_CYCLE_ENABLE == 1
    size_t cpu_cycle_load = cpu_cycle_app_start - cpu_cycle_start;
    size_t cpu_cycle_app = cpu_cycle_app_end - cpu_cycle_app_start;
    size_t cpu_cycle_unload = cpu_cycle_end - cpu_cycle_app_end;   
    printf("ESP32C6_Lua: Load   %d\n", cpu_cycle_load);
    printf("ESP32C6_Lua: Run    %d\n", cpu_cycle_app);
    printf("ESP32C6_Lua: Unload %d\n", cpu_cycle_unload);
    printf("ESP32C6_Lua: Total  %d\n", cpu_cycle_load + cpu_cycle_app + cpu_cycle_unload);
#endif

    ESP_LOGI(LOG_TAG, "Exiting...");
}
