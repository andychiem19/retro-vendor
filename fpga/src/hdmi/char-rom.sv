//encodes .hex font file in ASCII
module char_rom (
    input wire [10:0] addr,   // 11-bit address: 8 rows × 256 ASCII chars
    output reg [7:0] data
);

reg [7:0] font_mem [0:2047];  // 256 chars * 8 rows = 2048 entries

initial begin
    $readmemh("ibmbios.hex", font_mem);
end

always @(*) begin
    data = font_mem[addr];
end

endmodule