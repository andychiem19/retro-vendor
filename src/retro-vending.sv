module retro_vending ( // Main vending logic
  input clk,
  input reset,
  input coin_5,
  input coin_10,
  input coin_25,
  input next_item,
  input select,
  output reg dispense
);

  // Defines the states for the FSM
  parameter 	IDLE = 2'b00, COLLECTING = 2'b01, DISPENSING = 2'b10;

  wire [7:0]  total;              // 8-bit register to store inserted total
  wire        next_item_pulse;    // Debounced signal for next_item button
  reg [1:0]   state, next_state;  // Makes 2-bit registers to store states
  reg[1:0]    selected_item;      // Determines which item the user has selected for purchase
  reg [7:0]   item_prices [0:3];  

  // Debounces next_item
  edge_detector ed_nxt (
    .clk(clk),
    .reset(reset),
    .in_signal(next_item),
    .pulse(next_item_pulse)
  );
  
  // Stores 8-bit values for item prices
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      item_prices[0] <= 8'd25;
      item_prices[1] <= 8'd50;
      item_prices[2] <= 8'd100;
      item_prices[3] <= 8'd200;
    end
  end

  // Logic for next item button
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      selected_item <= 0;
    end 
    else if (next_item_pulse)
      selected_item <= selected_item + 1;
  end

	// Creates an instance of coin_accumulator in retro_vending
  coin_accumulator coin_inst (
    .clk(clk),
    .reset(reset),
    .coin_5(coin_5),
    .coin_10(coin_10),
    .coin_25(coin_25),
    .clear(state == DISPENSING),
    .total(total)
  );
  
	// State transition logic
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else
      state <= next_state;
  end
  
  always @(*) begin
    next_state = state;
    
    case(state)
      IDLE:
        if (coin_5 || coin_10 || coin_25)
          next_state <= COLLECTING; 
      
      COLLECTING:
        if (select && total >= item_prices[selected_item]) 
          next_state <= DISPENSING; 
      
      DISPENSING: 
      	next_state = IDLE; 
      
    endcase
  end
  
	// Sends dispense signal
  always @(posedge clk or posedge reset) begin
  	if (reset)
    	dispense <= 0;
    else if (state == DISPENSING)
    	dispense <= 1;
    else
      	dispense <= 0;
  end
endmodule
