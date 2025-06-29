module edge_detector  ( //Edge detector/debouncer
  input clk,
  input reset,
  input in_signal,
  output reg pulse
);

reg [20:0] counter = 0;
reg stable_in = 0;
reg debounced = 0;
reg prev_debounced = 0;

always @(posedge clk or posedge reset) begin
  // reset logic
  if (reset) begin
    counter <= 0;
    stable_in <= 0;
    debounced <= 0;
    prev_debounced <= 0;
    pulse <= 0;
  end

  // debouncer
  else begin
    if (in_signal == stable_in) begin
      if (counter < 21'd1250000) // 10ms at 125MHz
        counter <= counter + 1;
      else 
        debounced <= stable_in;
    end
    else begin
      stable_in <= in_signal;
      counter <= 0;
    end

    // edge detection
    pulse <= (debounced && !prev_debounced);
    prev_debounced <= debounced;
  end
end

endmodule