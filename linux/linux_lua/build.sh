#!/bin/sh

# We add some code to capture the cpu time/cpu cycles to this file
cp -f src/lua.c lua-5.4.7/

cd lua-5.4.7/
make clean
make all test
