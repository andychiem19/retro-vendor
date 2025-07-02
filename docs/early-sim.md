#### **Legacy Simulation Instructions**

1. Install VS Code (+Verilog/SystemVerilog extension) and Icarus Verilog 12.0 w/GTKWave 
2. Install the files in this directory and open it in VS Code
3. Run the following command in the Powershell terminal

```powershell
iverilog -g2012 -o sim.out src/*.sv tb/*.sv && vvp sim.out && if exist retro_vending.vcd ( start gtkwave retro_vending.vcd )
```

<a>
<a name="make-your-own"></a>
  
#### **Making your own testbenches**

You may want to simulate your own scenarios, so an example testbench is attached here with some example code.

```verilog
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

    /* USER CODE GOES HERE 

    //example of inserting a coin
    #50 coin_10 = 1;
    #10 coin_10 = 0;

    //example of scrolling through items
    #50 next_item = 1;
    #10 next_item = 0;
 
    // select
    #100 select = 1;
    #100 select = 0;

    */

    // wait a little to observe output
    #100;

    $finish;
  end

endmodule
```