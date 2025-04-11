#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

extern "C" {
    fn puts(input: *const u8) -> i32;
}

// Same as strlen() in C program
fn strlen(s: *const u8) -> usize {
    let mut len: usize = 0;
    unsafe {
        while *s.add(len) != 0 {
            len += 1;
        }
    }
    len
}


// Same as hex_to_int() in C program
// Convert a single hex character (ASCII code) to its numerical value 0-15.
fn hex_to_int(c: u8) -> u8 {
    if c >= b'0' && c <= b'9' {
        c - b'0'        // '0'-'9' -> 0-9
    } else if c >= b'A' && c <= b'F' {
        c - b'A' + 10   // 'A'-'F' -> 10-15
    } else if c >= b'a' && c <= b'f' {
        c - b'a' + 10   // 'a'-'f' -> 10-15 (in case lowercase is used)
    } else {
        0
    }
}



// Same as process_rgb_to_gray() in C program
// Parses the hex_input string as RGB data into shared_buffer,
// then converts each pixel to grayscale and writes the result to output_buffer.
fn process_rgb_to_gray(hex_ptr: *const u8, out_gray_ptr: *mut u8, pixel_count: usize) {
    for i in 0..pixel_count {
        let hex_index = i * 6;
        unsafe {
            // Read and convert each pair of hex characters for R, G, B
            let r_high = hex_to_int(*hex_ptr.add(hex_index));
            let r_low  = hex_to_int(*hex_ptr.add(hex_index + 1));
            let g_high = hex_to_int(*hex_ptr.add(hex_index + 2));
            let g_low  = hex_to_int(*hex_ptr.add(hex_index + 3));
            let b_high = hex_to_int(*hex_ptr.add(hex_index + 4));
            let b_low  = hex_to_int(*hex_ptr.add(hex_index + 5));
            
            // Combine two hex digits into one byte for each color component
            let r = (r_high << 4) | r_low;
            let g = (g_high << 4) | g_low;
            let b = (b_high << 4) | b_low;
            
            // Compute grayscale values using the standard luminance approximation:
            // gray = 0.299 * R + 0.587 * G + 0.114 * B
            let gray_val = ((r as u16 * 77 + g as u16 * 150 + b as u16 * 29) >> 8) as u8;
            *out_gray_ptr.add(i) = gray_val;
        }
    }
}


// Same as apply_brightness() in C program
// // Adjust brightness for a grayscale image
fn apply_brightness(gray_ptr: *mut u8, pixel_count: usize, brightness_offset: i8) {
    for i in 0..pixel_count {
        unsafe {
            let mut val = (*gray_ptr.add(i) as i16) + brightness_offset as i16;
            if val < 0 {
                val = 0;
            }
            if val > 255 {
                val = 255;
            }
            *gray_ptr.add(i) = val as u8;
        }
    }
}


// main()
#[no_mangle]
pub extern "C" fn main() {
    // 8×8 image - 64 pixels
    let test_image_hex: &[u8] = concat!(
        "47704C47704C47704C0000FFFFFE04040347704C47704C",
        "47704C95BF2BA9CB31467AB145194EFEFEF47704C47704C",
        "47704C9AC32DFFFFF135EA41451941237A0BBCD47704C",
        "000000FFFFFF49AEADB3D5E7C94265B94FFFFFF040503",
        "000000FFFFFFFEE404E3D236363531979255485F13000000",
        "47704CFFFFFFFEF02FF6F6F6F6E6EBF6E6EBF65F861C47704C",
        "47704C47704CE1E1E1F4F4F4F6F6F678A023FEFEFE47704C",
        "47704C47704C89B13B00000000000047704C47704CFFFFFF",
        "\0"
    ).as_bytes();
    let mut gray_output: [u8; 64] = [0; 64];

    let hex_len = strlen(test_image_hex.as_ptr());
    let pixel_count = hex_len / 6;

    process_rgb_to_gray(test_image_hex.as_ptr(), gray_output.as_mut_ptr(), pixel_count);
    apply_brightness(gray_output.as_mut_ptr(), pixel_count, 50);

    // let message = "Image app completed!\0";
    // unsafe {
    //     puts(message.as_ptr());
    // }
}
