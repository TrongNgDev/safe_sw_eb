#include <stdio.h>
#include <stdlib.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(int argc, char** argv)
{
    lua_State *L = luaL_newstate();
    if (L == NULL)
    {
        fprintf(stderr, "Failed to create new Lua state");
        return;
    }

    luaL_openlibs(L);
    if (luaL_loadfile(L, "../lua_applications/image_app.lua") != LUA_OK)
    {
        fprintf(stderr, "Error loading Lua script: %s", lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_close(L);
        exit(1);
    }

    if (lua_pcall(L, 0, LUA_MULTRET, 0) != LUA_OK) {
        fprintf(stderr, "Error running Lua script: %s", lua_tostring(L, -1));
        lua_pop(L, 1);
    }

    lua_close(L);

    return 0;
}
