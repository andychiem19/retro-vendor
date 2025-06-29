module retro_vending ( // Main vending logic
  input clk,
  input reset,
  input coin_5,
  input coin_10,
  input coin_25,
  input next_item,
  input select,
  output reg dispense,
  output reg [7:0] change
);

  // Defines the states for the FSM
  parameter 	IDLE = 2'b00, COLLECTING = 2'b01, DISPENSING = 2'b10;

  wire [7:0]  total;              // 8-bit register to store inserted total
  wire        next_item_pulse;    // Debounced signal for next_item button
  wire        select_pulse;       // Debounced signal for select button
  reg [1:0]   state, next_state;  // Makes 2-bit registers to store states
  reg[1:0]    selected_item;      // Determines which item the user has selected for purchase
  reg [7:0]   item_prices [0:3];  
  reg [26:0] dispense_timer = 0; 
  reg        dispense_flag = 0;

  // Debounces next_item
  edge_detector ed_nxt (
    .clk(clk),
    .reset(reset),
    .in_signal(next_item),
    .pulse(next_item_pulse)
  );

  // Debounces select
  edge_detector ed_sel (
    .clk(clk),
    .reset(reset),
    .in_signal(select),
    .pulse(select_pulse)
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
          next_state = COLLECTING; 
      
      COLLECTING:
        if (select_pulse && total >= item_prices[selected_item]) 
          next_state = DISPENSING; 
      
      DISPENSING: 
      	next_state = IDLE; 
      
    endcase
  end
  
	// Sends dispense signal
  always @(posedge clk or posedge reset) begin
  	if (reset) begin
    	dispense <= 0;
      change <= 0;
      dispense_timer <= 0;
      dispense_flag <= 0;
    end
    else if (state == DISPENSING) begin
      dispense_timer <= 27'd125000000;
    	dispense_flag <= 1;
      change <= total - (item_prices[selected_item]);
    end
    else if (dispense_timer > 0) begin
      dispense_timer <= dispense_timer - 1;
    end

    else begin
      	dispense_flag <= 0;
        change <= 0;
    end

    dispense <= dispense_flag;
  end
endmodule
