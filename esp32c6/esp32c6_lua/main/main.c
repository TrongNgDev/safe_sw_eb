/*
 * SPDX-FileCopyrightText: 2010-2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: CC0-1.0
 */

#include <stdio.h>
#include <inttypes.h>
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_chip_info.h"
#include "esp_flash.h"
#include "esp_log.h"
#include "esp_system.h"

// Lua runtime
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

// Lua application
#include "../../../applications/image_app_lua/image_app_lua.h"

#define CPU_CYCLE_ENABLE 1
#define LOG_ENABLE 0
#define LOG_TAG "Lua"

size_t cpu_cycle_start = 0;
size_t cpu_cycle_end = 0;
size_t cpu_cycle_app_start = 0;
size_t cpu_cycle_app_end = 0;


void run_embedded_lua(const char *lua_script, size_t lua_script_len)
{
    #if CPU_CYCLE_ENABLE == 1
        cpu_cycle_start = esp_cpu_get_cycle_count();
    #endif

    lua_State *L = luaL_newstate();
    if (L == NULL)
    {
        ESP_LOGE(LOG_TAG,"Failed to create new Lua state");
        return;
    }

    luaL_openlibs(L);
    if (luaL_loadbuffer(L, lua_script, lua_script_len, "lua_script") != LUA_OK)
    {
        ESP_LOGE(LOG_TAG,"Error loading Lua script: %s", lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_close(L);
        return;
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
}

void app_main(void)
{
    ESP_LOGI(LOG_TAG,"Call Lua program.");
    run_embedded_lua((const char*)image_app_lua, (size_t)image_app_lua_len);
    ESP_LOGI(LOG_TAG,"End of Lua program.");

#if CPU_CYCLE_ENABLE == 1
    size_t cpu_cycle_load = cpu_cycle_app_start - cpu_cycle_start;
    size_t cpu_cycle_app = cpu_cycle_app_end - cpu_cycle_app_start;
    size_t cpu_cycle_unload = cpu_cycle_end - cpu_cycle_app_end;   
    printf("Lua: cpu cycles - load Lua:    %d\n", cpu_cycle_load);
    printf("Lua: cpu cycles - run Lua app: %d\n", cpu_cycle_app);
    printf("Lua: cpu cycles - unload Lua:  %d\n", cpu_cycle_unload);
    printf("Lua: cpu cycles - total:       %d\n", cpu_cycle_load + cpu_cycle_app + cpu_cycle_unload);
#endif

    return;
}
