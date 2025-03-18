#include <stdint.h>
#include <stdio.h>

#define WASM_EXPORT __attribute__((visibility("default")))

#define BUFFER_SIZE 256
static uint8_t shared_buffer[BUFFER_SIZE];

// Custom strlen to avoid using standard library in certain embedded/wasm environments
size_t strlen(const char *s) {
    const char *end = s;
    while (*end++) ;
    return end - s - 1;
}

// Converts a single hex character to an integer. Returns -1 for invalid characters.
static inline int hex_to_int(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return -1;
}

// Parses the hex_input string as RGB data into shared_buffer,
// then converts each pixel to grayscale and writes the result to output_buffer.
WASM_EXPORT
int process_rgb_to_gray(const char* hex_input, uint32_t width, uint32_t height, uint8_t* output_buffer) {
    size_t str_len = strlen(hex_input);
    // Hex string length must be even
    if (str_len % 2 != 0) {
        return -1;
    }

    size_t bytes_len = str_len / 2;
    // If the byte count exceeds the buffer capacity, return error
    if (bytes_len > BUFFER_SIZE) {
        return -2;
    }

    // Convert the hex string to raw bytes in shared_buffer
    for (size_t i = 0; i < bytes_len; i++) {
        int high = hex_to_int(hex_input[i * 2]);
        int low  = hex_to_int(hex_input[i * 2 + 1]);
        if (high == -1 || low == -1) {
            return -3;
        }
        shared_buffer[i] = (uint8_t)((high << 4) | low);
    }

    // Compute grayscale values using the standard luminance approximation:
    // gray = 0.299 * R + 0.587 * G + 0.114 * B
    for (size_t i = 0; i < width * height; i++) {
        const uint8_t* pixel = &shared_buffer[i * 3];
        uint32_t gray_val = (pixel[0] * 77 + pixel[1] * 150 + pixel[2] * 29) >> 8;
        output_buffer[i] = (uint8_t)gray_val;
    }

    // Return the total number of processed pixels
    return (int)(width * height);
}

// Adjust brightness for a grayscale image
WASM_EXPORT
int apply_brightness(uint8_t* grayscale, size_t length, int16_t brightness_offset) {
    for (size_t i = 0; i < length; i++) {
        int val = (int)grayscale[i] + (int)brightness_offset;
        if (val < 0)   val = 0;
        if (val > 255) val = 255;
        grayscale[i] = (uint8_t)val;
    }
    return (int)length;
}

int main(int argc, char **argv)
{
    // 4. Replace the dummy hex data below with the full hex string
    //    for your 256-pixel (or fewer) test image, ensuring bytes <= 256.
    static const char test_image_hex[] =
        "47704C47704C47704C000000FFFFFF04040347704C47704C"
        "47704C95BF2BA9CB431467AB145194EFEFEF47704C47704C"
        "47704C9AC32DFFFFFF135EA4145194123C73A0BBCD47704C"
        "000000FFFFFF49AEDA8DD3F05E7C94265B94FFFFFF040503"
        "000000FFFFFFFEE404E3D236363531979255485F13000000"
        "47704CFFFFFFFEF02FF6F6F6E6EBF6E6EBF65F861C47704C"
        "47704C47704CE1E1E1F4F4F4F6F6F678A023FEFEFE47704C"
        "47704C47704C89B13B00000000000047704C47704CFFFFFF";

    uint32_t width = 8;
    uint32_t height = 8;

    // Allocate a buffer to hold the grayscale output
    static uint8_t gray_output[64];
    
    puts("Start processing test_image_hex...");

    int ret = process_rgb_to_gray(test_image_hex, width, height, gray_output);
    if (ret < 0) {
        puts("process_rgb_to_gray failed");
        return -1;
    }

    puts("process_rgb_to_gray success!");
    
    return 0;
}
