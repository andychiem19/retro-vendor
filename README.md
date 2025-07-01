### Retro Vending Machine
A Verilog/SystemVerilog based vending machine FSM intended for FPGA simulation. Accepts multiple coin inputs, tracks total value, and triggers a dispense signal once sufficient funds are collected.

**Tools Used**

`Visual Studio Code`
`Verilog/SystemVerilog`
`Vivado`
`Git`
`Icarus Verilog 12.0`
`GTKWave`

---

#### **Learning Objectives**

- RTL design and verification with FSM control, testbenches, and waveform debugging in GTKWave
- Hardware-synthesizable I/O management using debouncing and edge-detection for real-world inputs
- HDMI signal generation with clocked video timing logic for digital display output on FPGA

---

#### **Project Features & Timeline**

| Feature | Description | Timeline |
|--------|-------------|--------|
| Finite State Machine | With `IDLE`, `COLLECTING`, and `DISPENSING` states | 6/25/2025
| Modular Design | Separate logic for vending, coin accumulation, and edge detection | 
| Coin Accumulator | Accepts 5¢, 10¢, and 25¢ coins and maintains an accurate running total | 
| Debounced Inputs | Edge-detected coin/button inputs for hardware synthesizability | 6/26/2025
| Item Selection | Scrolling selector with four unique item-price pairs | 
| Change Return | Stores leftover money after purchase for change return | 6/29/2025
| FPGA Deployment Prep | Synthesis, implementation, constraints, and top-level wiring completed |

*Planned Features* 
| Feature | Description |
|--------|-------------|
| Initial FPGA Deployment | Flashing bitstream to Zybo-Z7, with I/O limited to onboard buttons and LEDs |
| HDMI Video Output | Direct framebuffer or text-based video output over HDMI from programmable logic (PL) |
| Pixel Graphics | Simple pixel or tile-based UI |

---
#### **Demos**

<iframe width="560" height="315" src="https://www.youtube.com/embed/YAWXXol3p50?si=F_tX5mKkLMV4oSuX" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

*First hardware demo*

#### **Simulation Instructions**

1. Install VS Code and Icarus Verilog 12.0 w/GTKWave
2. [Install the module files here](src)
3. [Install a testbench](tb) or [make your own](#make-your-own)
4. Run the following command in the Powershell terminal after setting Icarus Verilog 12.0 as your compiler

```powershell
iverilog -g2012 -o sim.out src/*.sv tb/retro-vending_tb.sv && vvp sim.out && if exist retro_vending.vcd ( start gtkwave retro_vending.vcd )
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
