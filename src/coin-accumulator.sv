module coin_accumulator ( // Logic for accumulation of currency
  input clk,
  input reset,
  input clear,
  input coin_5,
  input coin_10,
  input coin_25,
  output reg [7:0] total
);

  reg pulse_25;
  reg pulse_10;
  reg pulse_5;

  // Ports of edge detectors
  edge_detector ed_25 (
    .clk(clk),
    .reset(reset),
    .in_signal(coin_25),
    .pulse(pulse_25)
  );

  edge_detector ed_10 (
    .clk(clk),
    .reset(reset),
    .in_signal(coin_10),
    .pulse(pulse_10)
  );

  edge_detector ed_5 (
    .clk(clk),
    .reset(reset),
    .in_signal(coin_5),
    .pulse(pulse_5)
  );
  
  always @(posedge clk or posedge reset) begin
    if (reset || clear)
      total <= 0;
    else 
      total <= total  + (pulse_5 ? 7'd5 : 7'd0) 
                      + (pulse_10 ? 7'd10 : 7'd0)
                      + (pulse_25 ? 7'd25 : 7'd0); //Constantly adds the enabled pulses on positive clock edges
                      
  end
endmodule
