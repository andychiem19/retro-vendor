module text_overlay (
    input  wire [9:0] x,
    input  wire [9:0] y,
    input  wire show_text,   
    output reg  text_pixel,

    input wire [1:0] state,
    input wire [7:0] total,         // e.g., 75 for 75¢
    input wire [7:0] change,        // e.g., 25 for 25¢
    input wire [1:0] selected_item
);

// Display config
localparam CHAR_WIDTH  = 8;
localparam CHAR_HEIGHT = 8;
localparam X_START = 280;
localparam Y_START = 200;

// Compute tile coordinates
wire [6:0] char_col = (x - X_START) >> 3;
wire [9:0] y_offset = y - Y_START;
wire [3:0] char_row = y_offset >> 3;
wire [2:0] row_in_char = y_offset[2:0];
wire [2:0] col_in_char = ~x[2:0]; // MSB-first

// Font ROM hookup
reg  [7:0] ascii;
wire [10:0] font_addr = {ascii, row_in_char};
wire [7:0] current_row_bitmap;

char_rom rom (
    .addr(font_addr),
    .data(current_row_bitmap)
);

// ASCII digit helpers
wire [7:0] total_hundreds = ((total / 100) % 10) + 8'h10;
wire [7:0] total_tens   = ((total / 10) % 10) + 8'h10;
wire [7:0] total_ones   = (total % 10) + 8'h10;
wire [7:0] change_tens  = ((change / 10) % 10) + 8'h10;
wire [7:0] change_ones  = (change % 10) + 8'h10;

// Text logic
always @(*) begin
    if (!show_text ||
        x < X_START || x >= (X_START + 16 * CHAR_WIDTH) ||
        y < Y_START || y >= (Y_START + CHAR_HEIGHT))
    begin
        ascii = 8'h00;         // space
        text_pixel = 0;
    end else begin
        case (state)
            // IDLE: "INSERT COIN"
            2'b00: case (char_col)
                0:  ascii = 8'h29; // I
                1:  ascii = 8'h2E; // N
                2:  ascii = 8'h33; // S
                3:  ascii = 8'h25; // E
                4:  ascii = 8'h32; // R
                5:  ascii = 8'h34; // T
                6:  ascii = 8'h00; // (space)
                7:  ascii = 8'h23; // C
                8:  ascii = 8'h2F; // O
                9:  ascii = 8'h29; // I
                10: ascii = 8'h2E; // N
                default: ascii = 8'h00;
            endcase

            // COLLECTING: "TOTAL: NN¢"
            2'b01: case (char_col)
                0:  ascii = 8'h34; // T
                1:  ascii = 8'h2F; // O
                2:  ascii = 8'h34; // T
                3:  ascii = 8'h21; // A
                4:  ascii = 8'h2C; // L
                5:  ascii = 8'h1A; // :
                6:  ascii = 8'h00; // (space)
                7:  ascii = total_hundreds;
                8:  ascii = total_tens;
                9:  ascii = total_ones;
                10: ascii = 8'h43; // c (used as fake ¢)
                default: ascii = 8'h00;
            endcase

            // CHANGE: "CHANGE: NN¢"
            2'b10: case (char_col)
                0:  ascii = 8'h23; // C
                1:  ascii = 8'h28; // H
                2:  ascii = 8'h21; // A
                3:  ascii = 8'h2E; // N
                4:  ascii = 8'h27; // G
                5:  ascii = 8'h25; // E
                6:  ascii = 8'h1A; // :
                7:  ascii = 8'h00; // (space)
                8:  ascii = change_tens;
                9:  ascii = change_ones;
                10: ascii = 8'h43; // c (used as fake ¢)
                default: ascii = 8'h00;
            endcase
        endcase

        text_pixel = current_row_bitmap[col_in_char];
    end
end

endmodule