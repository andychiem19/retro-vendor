module serializer (
    input wire clk_250mhz,
    input wire [9:0] o_tmds,
    output reg serial_out
);

reg [9:0] shift_reg;
reg [3:0] counter;

wire load_new;
assign load_new = (counter == 4'd0);

always @(posedge clk_250mhz) begin
    if (counter == 4'd9)
    counter <= 0;
    else
    counter <= counter + 1;
end

always @(posedge clk_250mhz) begin
    if (load_new) begin
        shift_reg <= o_tmds;
    end else begin
        shift_reg <= {1'b0, shift_reg[9:1]};
    end
    serial_out <= shift_reg[0];
end

endmodule