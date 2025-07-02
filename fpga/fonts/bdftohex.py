def parse_bdf_to_hex(bdf_path: str, output_path: str):
    with open(bdf_path, "r") as f:
        lines = [line.strip() for line in f.readlines()]

    glyphs = {}
    current_encoding = None
    bitmap = []
    in_bitmap = False

    for line in lines:
        if line.startswith("STARTCHAR"):
            bitmap = []
            current_encoding = None
            in_bitmap = False
        elif line.startswith("ENCODING"):
            try:
                current_encoding = int(line.split()[1])
            except ValueError:
                current_encoding = None
        elif line == "BITMAP":
            in_bitmap = True
        elif line == "ENDCHAR":
            if current_encoding is not None and 32 <= current_encoding <= 126:
                pad = max(0, 8 - len(bitmap))
                padded_bitmap = ['00'] * pad + bitmap[:8]
                glyphs[current_encoding] = padded_bitmap
            bitmap = []
            current_encoding = None
            in_bitmap = False
        elif in_bitmap:
            bitmap.append(line.upper())

    with open(output_path, "w") as f:
        for code in range(32, 127):
            glyph = glyphs.get(code, ['00'] * 8)
            for row in glyph:
                f.write(row + "\n")

    print(f"✅ Wrote {output_path} with {len(glyphs)} glyphs.")

# Call the function here:
parse_bdf_to_hex("/Users/homew/OneDrive/Documents/retro-vendor/fpga/fonts/ibmega8x8.bdf", "ibmega8x8.hex")
