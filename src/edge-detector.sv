module edge_detector  ( //Edge detector/debouncer
  input clk,
  input reset,
  input in_signal,
  output reg pulse
);

reg prev_signal;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    prev_signal <= 0;
    pulse <= 0;
  end 
  else begin
    pulse <= (in_signal && !prev_signal);
    prev_signal <= in_signal;
  end
end
endmodule
