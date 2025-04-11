# ESP-IDF ESP32C6 projects - Lua part
This part evaluates the feasibility of applying Lua to ESP32C6 board as well as its performance.

## 1. Hardware
- [ESP32-C6-DevKitC-1](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c6/esp32-c6-devkitc-1/index.html)


## 2. Prerequisites
- ESP-IDF version 5.4
- Lua 5.4.7: can be downloaded from the [Lua website](https://lua.org/download.html) or added as dependency as below.
    ```
    idf.py add-dependency "georgik/lua^5.4.7"
    ```

## 3. Project Configuration
The project configuration for Lua is defined in .
- Update the Lua stack size ```LUA_MAXSTACK``` in `sdkconfig.defaults` if necessary. Its default value is 1000000.
- Modify ```luaconf.h``` to define 32-bit CPU architecture by setting ```LUA_32BITS``` 1.

## 4. Lua application
Lua applications are placed at ```../applications/image_app_lua/```.

There are several ways to invoke the Lua code in ESP32C6.

1. Run embedded Lua:

    1.1 Hex dump (xxd) Lua file (.lua) to a C header file (.h) and include it to the main program.

    1.2. Convert Lua file to a string and include it to the main program.

2. Run Lua from file: 
    
    Store Lua file in a file system image in the ESP32C6 flash memory using 
[SPIFFS](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/storage/spiffs.html), [FAT](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/storage/fatfs.html),
or [LittleFS](https://components.espressif.com/components/joltwallet/littlefs/versions/1.17.0).

In this project, we use the solution 1.1 to have a fair comparision with Wasm.

## 5. How to run
Connect the ESP32C6 board to PC, then go to `esp32c6_lua/` and invoke the script
```./build_and_run.sh```. The content of this script is as below.
```
idf.py set-target esp32c6
idf.py build
idf.py flash
idf.py monitor
```