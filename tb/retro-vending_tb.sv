`timescale 1ns / 1ps 

module retro_vending_tb;

  reg clk;
  reg reset;
  reg coin_5;
  reg coin_10;
  reg coin_25;
  reg select;
  reg next_item;
  wire dispense;

  retro_vending uut (
    .clk(clk),
    .reset(reset),
    .coin_5(coin_5),
    .coin_10(coin_10),
    .coin_25(coin_25),
    .select(select),
    .dispense(dispense),
    .next_item(next_item)
  );

  always #5 clk = ~clk;

  initial begin
    
    $dumpfile("retro_vending.vcd");
    $dumpvars;

    clk = 0;
    reset = 1;
    next_item = 0;
    coin_5 = 0;
    coin_10 = 0;
    coin_25 = 0;
    select = 0;

    #100 reset = 0;

    #50 coin_10 = 1;
    #10 coin_10 = 0;

    #50 next_item = 1;
    #10 next_item = 0;
 
    #100 select = 1;
    #100 select = 0;

    // wait a little to observe output
    #100;

    $finish;
  end

endmodule