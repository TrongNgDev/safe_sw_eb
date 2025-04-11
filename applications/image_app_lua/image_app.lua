-- switch hex character to integer 
local function hex_to_int(c)
    if c >= '0' and c <= '9' then
        return string.byte(c) - string.byte('0')
    elseif c >= 'a' and c <= 'f' then
        return string.byte(c) - string.byte('a') + 10
    elseif c >= 'A' and c <= 'F' then
        return string.byte(c) - string.byte('A') + 10
    else
        return -1
    end
end


local function process_rgb_to_gray(hex_input, pixel_count)
    local output_buffer = {}
    for i = 1, pixel_count do
        local hex_index = (i - 1) * 6 + 1
        
        -- Read and convert each pair of hex characters for R, G, B.
        local r_high = hex_to_int( hex_input:sub(hex_index, hex_index) )
        local r_low  = hex_to_int( hex_input:sub(hex_index+1, hex_index+1) )
        local g_high = hex_to_int( hex_input:sub(hex_index+2, hex_index+2) )
        local g_low  = hex_to_int( hex_input:sub(hex_index+3, hex_index+3) )
        local b_high = hex_to_int( hex_input:sub(hex_index+4, hex_index+4) )
        local b_low  = hex_to_int( hex_input:sub(hex_index+5, hex_index+5) )
        
        -- Combine two hex digits into one byte for each color component.
        local r = (r_high * 16) + r_low
        local g = (g_high * 16) + g_low
        local b = (b_high * 16) + b_low

        -- Compute grayscale value using the luminance approximation:
        -- gray = (r*77 + g*150 + b*29) >> 8
        local gray_val = math.floor((r * 77 + g * 150 + b * 29) / 256)
        output_buffer[i] = gray_val
    end
    return output_buffer
end


local function apply_brightness(gray_buffer, pixel_count, brightness_offset)
    for i = 1, pixel_count do
        local val = gray_buffer[i] + brightness_offset
        if val < 0 then
            val = 0
        elseif val > 255 then
            val = 255
        end
        gray_buffer[i] = val
    end
end

-- Utility function to print the 8x8 grayscale image.
-- local function print_image(gray_buffer, width, height)
--     for i = 1, height do
--         local row = {}
--         for j = 1, width do
--             table.insert(row, gray_buffer[(i-1)*width + j])
--         end
--         print(table.concat(row, " "))
--     end
-- end

-- Main function
local function main()
    -- Define an 8x8 image (64 pixels) as a hex string.
    -- The string is concatenated from multiple lines.
    local test_image_hex = table.concat({
        "47704C47704C47704C0000FFFFFE04040347704C47704C",
        "47704C95BF2BA9CB31467AB145194EFEFEF47704C47704C",
        "47704C9AC32DFFFFFF135EA41451941237A0BBCD47704C",
        "000000FFFFFF49AEADB3D5E7C94265B94FFFFFF040503",
        "000000FFFFFFFEE404E3D236363531979255485F13000000",
        "47704CFFFFFFFEF02FF6F6F6F6E6EBF6E6EBF65F861C47704C",
        "47704C47704CE1E1E1F4F4F4F6F6F678A023FEFEFE47704C",
        "47704C47704C89B13B00000000000047704C47704CFFFFFF",
    }, "")
    
    -- Calculate the length of the hex string and number of pixels.
    local hex_len = #test_image_hex
    local pixel_count = math.floor(hex_len / 6)   
    -- print("Start processing RGB to gray...")
    
    -- Process the image to convert from RGB hex to grayscale.
    local gray_output = process_rgb_to_gray(test_image_hex, pixel_count)

    -- print("Grayscale applied.\nOutput Pixels:")
    -- print_image(gray_output, 8, 8)

    -- Apply a brightness offset of +50.
    -- print("Applying brightness offset +50...")
    apply_brightness(gray_output, pixel_count, 50)
    
    -- print("Brightness applied.\nOutput Pixels:")
    -- print_image(gray_output, 8, 8)
    -- print("Image processing completed!")
end

main()
