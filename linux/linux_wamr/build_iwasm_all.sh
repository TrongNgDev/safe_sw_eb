#!/bin/sh

cd WAMR

rm -f iwasm_ci iwasm_fi iwasm_aot iwasm_fast_jit iwasm_llvm_jit

./build_classic_interpreter.sh
./build_fast_interpreter.sh
./build_aot.sh

echo "\n*** Make sure the LLVM was installed, if not run the build_llvm.sh ***\n"
./build_llvm_jit.sh
./build_fast_jit.sh

echo "Done!"