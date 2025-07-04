module vga_generator(
    input wire clk_25mhz, //25 MHz clock for 640x480 VGA output
    input wire reset,
    input wire show_text,
    output wire h_sync,
    output wire v_sync,
    output wire [7:0] red,
    output wire [7:0] green,
    output wire [7:0] blue,
    output wire video_on,
    
    input wire [1:0] state,
    input wire [7:0] total,
    input wire [7:0] change,
    input wire dispense,
    input wire [1:0] selected_item
  
);

//VGA standard constants for 640x480 @60Hz
localparam H_ACTIVE = 640;
localparam H_FRONT = 16;
localparam H_SYNC = 96;
localparam H_BACK = 48;
localparam H_TOTAL = 800;

localparam V_ACTIVE = 480;
localparam V_FRONT = 10;
localparam V_SYNC = 2;
localparam V_BACK = 33;
localparam V_TOTAL = 525;

reg [9:0] h_count = 0;
reg [9:0] v_count = 0;

always @(posedge clk_25mhz or posedge reset) begin
    if (reset) begin
        h_count <= 0;
        v_count <= 0;
    end else begin
        if (h_count == H_TOTAL - 1) begin
            h_count <= 0;
            if (v_count == V_TOTAL - 1)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end else begin
            h_count <= h_count + 1;
        end
    end
end

assign h_sync = ~((h_count >= H_ACTIVE + H_FRONT) && (h_count < H_ACTIVE + H_FRONT + H_SYNC));
assign v_sync = ~((v_count >= V_ACTIVE + V_FRONT) && (v_count < V_ACTIVE + V_FRONT + V_SYNC));

assign video_on = (h_count < H_ACTIVE) && (v_count < V_ACTIVE);

  // Output color
  wire text_on;

text_overlay overlay (
    .x(h_count),
    .y(v_count),
    .show_text(show_text),
    .text_pixel(text_on),
    .state(state),
    .total(total),
    .change(change),
    .selected_item(selected_item)
);

assign red   = (video_on && text_on) ? 8'hFF : 8'h00;
assign green = (video_on && text_on) ? 8'hFF : 8'h00;
assign blue  = (video_on && text_on) ? 8'hFF : 8'h00;

endmodule