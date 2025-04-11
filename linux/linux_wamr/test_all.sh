#!/bin/sh

wasm_app_image_c="../../applications/image_app_c/image_app.wasm "
wasm_app_image_rust="../../applications/image_app_rust/image_app.wasm"
aot_app_image_c="../../applications/image_app_c/image_app_x86_64_gnu.aot "
aot_app_image_rust="../../applications/image_app_rust/image_app_x86_64_gnu.aot"

loop_count=1000

report_dir="reports"

if [ ! -d "$report_dir" ]; then
  mkdir -p "$report_dir"
  echo "Created folder: $report_dir"
fi

echo "\n*****************************************************"
echo "*           WAMR - Classic Interpreter              *"
echo "*****************************************************"
echo "Linux_WAMR_CI_C: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_ci $wasm_app_image_c >> "$report_dir"/report_CI_C.txt
done

echo "\nLinux_WAMR_CI_Rust: "
for i in $(seq 1 100); do
./WAMR/iwasm_ci $wasm_app_image_rust >> "$report_dir"/report_CI_Rust.txt
done


echo "\n*****************************************************"
echo "*           WAMR - Fast Interpreter                 *"
echo "*****************************************************"
echo "Linux_WAMR_FI_C: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_fi $wasm_app_image_c >> "$report_dir"/report_FI_C.txt
done

echo "\nLinux_WAMR_FI_Rust: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_fi $wasm_app_image_rust >> "$report_dir"/report_FI_Rust.txt
done


echo "\n*****************************************************"
echo "*           WAMR - AOT                              *"
echo "*****************************************************"
echo "Linux_WAMR_AOT_C: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_aot $aot_app_image_c >> "$report_dir"/report_AOT_C.txt
done

echo "\nLinux_WAMR_AOT_Rust: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_aot $aot_app_image_rust >> "$report_dir"/report_AOT_Rust.txt
done


echo "\n*****************************************************"
echo "*           WAMR - LLVM JIT                         *"
echo "*****************************************************"
echo "Linux_WAMR_LLVM_JIT_C: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_llvm_jit $aot_app_image_c >> "$report_dir"/report_LLVMJIT_C.txt
done

echo "\nLinux_WAMR_LLVM_JIT_Rust: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_llvm_jit $aot_app_image_rust >> "$report_dir"/report_LLVMJIT_Rust.txt
done


echo "\n*****************************************************"
echo "*           WAMR - Fast JIT                         *"
echo "*****************************************************"
echo "Linux_WAMR_Fast_JIT_C: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_fast_jit $aot_app_image_c >> "$report_dir"/report_FJIT_C.txt
done

echo "\nLinux_WAMR_Fast_JIT_Rust: "
for i in $(seq 1 $loop_count); do
./WAMR/iwasm_fast_jit $aot_app_image_rust >> "$report_dir"/report_FJIT_Rust.txt
done


echo "\nDone!"
