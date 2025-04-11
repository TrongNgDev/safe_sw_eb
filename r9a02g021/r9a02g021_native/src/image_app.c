#include <stdint.h>
#include <stdio.h>

//#define WASM_EXPORT __attribute__((visibility("default")))
#define LOG_ENABLE 0

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
//WASM_EXPORT
void process_rgb_to_gray(const char* hex_input, uint8_t* output_buffer, size_t pixel_count) {
    for (size_t i = 0; i < pixel_count; i++) {
        int hex_index = i * 6;
        // Read and convert each pair of hex characters for R, G, B
        int r_high = hex_to_int(hex_input[hex_index]);
        int r_low  = hex_to_int(hex_input[hex_index + 1]);
        int g_high = hex_to_int(hex_input[hex_index + 2]);
        int g_low  = hex_to_int(hex_input[hex_index + 3]);
        int b_high = hex_to_int(hex_input[hex_index + 4]);
        int b_low  = hex_to_int(hex_input[hex_index + 5]);

        // Combine two hex digits into one byte for each color component
        int r = (r_high << 4) | r_low;
        int g = (g_high << 4) | g_low;
        int b = (b_high << 4) | b_low;

        // Compute grayscale values using the standard luminance approximation:
        // gray = 0.299 * R + 0.587 * G + 0.114 * B
        uint32_t gray_val = (r*77 + g*150 + b*29) >> 8;
        output_buffer[i] = (uint8_t)gray_val;
    }
}

// Adjust brightness for a grayscale image
//WASM_EXPORT
void apply_brightness(uint8_t* gray_ptr, size_t pixel_count, int16_t brightness_offset) {
    for (size_t i = 0; i < pixel_count; i++) {
        int val = (int)gray_ptr[i] + (int)brightness_offset;
        if (val < 0) {
            val = 0;
        }
        if (val > 255) {
            val = 255;
        }
        gray_ptr[i] = (uint8_t)val;
    }
}

int image_app_main()
{
    // 8×8 image - 64 pixels
    static const char test_image_hex[] =
        "47704C47704C47704C0000FFFFFE04040347704C47704C"
        "47704C95BF2BA9CB31467AB145194EFEFEF47704C47704C"
        "47704C9AC32DFFFFFF135EA41451941237A0BBCD47704C"
        "000000FFFFFF49AEADB3D5E7C94265B94FFFFFF040503"
        "000000FFFFFFFEE404E3D236363531979255485F13000000"
        "47704CFFFFFFFEF02FF6F6F6F6E6EBF6E6EBF65F861C47704C"
        "47704C47704CE1E1E1F4F4F4F6F6F678A023FEFEFE47704C"
        "47704C47704C89B13B00000000000047704C47704CFFFFFF";

    static uint8_t gray_output[64];
    size_t hex_len = strlen(test_image_hex);
    size_t pixel_count = hex_len / 6;

    // Apply grayscale
#if LOG_ENABLE == 1
    printf("Start processing RGB to gray..\n");
#endif
    process_rgb_to_gray(test_image_hex, gray_output, pixel_count);
#if LOG_ENABLE == 1
    printf("Grayscale applied.\nOutput Pixel:\n");
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++){
            printf("%d ", gray_output[i * 8 + j]);
        }
        printf("\n");
    }
#endif

    // Apply a brightness offset： +50
#if LOG_ENABLE == 1
    printf("Applying brightness offset +50...\n");
#endif
    apply_brightness(gray_output, pixel_count, 50);
#if LOG_ENABLE == 1
    printf("Brightness applied.\nOutput Pixel:\n");
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++){
            printf("%d ", gray_output[i * 8 + j]);
        }
        printf("\n");
    }
    printf("Image app completed!\n");
#endif
    return 0;
}
