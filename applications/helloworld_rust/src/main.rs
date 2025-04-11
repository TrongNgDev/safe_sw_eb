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
    let message = "Hello World From Rust!\0";
    unsafe {
        puts(message.as_ptr());
    }
}
