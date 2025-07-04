// Runs reset on module startup once to properly initialize all signals
module startup_reset (
    input clk,
    output reg reset
);

reg [20:0] counter = 0;

always @(posedge clk) begin
  if (counter < 21'd1250000) begin  // 10ms reset
    reset <= 1;
    counter <= counter + 1;
  end else begin
    reset <= 0;
  end
end

endmodule