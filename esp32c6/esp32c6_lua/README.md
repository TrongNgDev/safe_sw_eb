# Running Lua on ESP32C6

This project evaluate the performance of Lua running on ESP32C6 ([ESP32-C6-DevKitC-1](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c6/esp32-c6-devkitc-1/index.html))

## Prerequisites
- ESP-IDF version 5.4.0 (We did not check with older versions)
- Lua 5.4.7: can be downloaded from the [Lua website](https://www.lua.org/) or added as dependency as below.
    ```
    idf.py add-dependency "georgik/lua^5.4.7"
    ```

## Configuration
- Update the Lua stack size in sdkconfig if necessary: ```LUA_MAXSTACK``` default value: 1000000.
- Modify ```luaconf.h``` to change value of ```LUA_32BITS``` from 0 to 1.

## Lua application
Lua applications are placed at ```../lua_application```.

There are several ways to invoke the Lua code in ESP32C6.

1. Run embedded Lua:

    1.1 Hex dump (xxd) Lua file (.lua) to a C header file (.h) and include it to the main program.

    1.2. Convert Lua file to a string and include it to the main program.

2. Run Lua from file: 
    
    Store Lua file in a file system image in the ESP32C6 flash memory using 
[SPIFFS](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/storage/spiffs.html), [FAT](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/storage/fatfs.html),
or [LittleFS](https://components.espressif.com/components/joltwallet/littlefs/versions/1.17.0).

In this project, we use the solution 1.1 to have a fair comparision with Wasm.

## Build and Flash
```
idf.py set-target esp32c6
idf.py build
idf.py flash
idf.py monitor
```
