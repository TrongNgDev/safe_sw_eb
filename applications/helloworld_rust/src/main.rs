#![no_std]
#![no_main]

use core::panic::PanicInfo;

/// Panic handler (for 'no_std' applications)
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

extern "C" {
    fn puts(input: *const u8) -> i32;
}

#[no_mangle]
pub extern "C" fn main() {
    let hello = "Hello World From Rust!\0";
    let hello_ptr: *const u8 = hello.as_ptr();
    let world_ptr: *const u8 = unsafe { hello_ptr.add(6) };

    unsafe {
        puts(hello_ptr);
        puts(world_ptr);
    }
}