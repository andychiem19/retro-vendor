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
- VGA signal generation with clocked video timing logic for digital display output
- TMDS encoding and manual serialization of data signals

---

#### **File Structure**

`/docs` - Extra documentation that you probably can't be bothered to read\
`/fpga` - Current version of the project, FPGA implementation source code, top file, and Xilinx constraints\
`/src` - Legacy source code\
`/tb` - Legacy testbenches

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
| Initial FPGA Deployment | Flashing bitstream to Zybo-Z7, with I/O limited to onboard buttons and LEDs | 7/1/2025

*Planned Features* 
| Feature | Description |
|--------|-------------|
| HDMI Video Output | Direct framebuffer or text-based video output over HDMI from programmable logic (PL) |
| Pixel Graphics | Simple pixel or tile-based UI |

---

#### **Demos**

[**Initial RTL verification**](https://www.youtube.com/embed/YAWXXol3p50?si=F_tX5mKkLMV4oSuX) –
Uses on-board I/O to verify RTL; demonstrates that debouncer functions properly and responds well to real-world button inputs

---
#### **Simulation (Legacy FSM)**
This project began as an RTL FSM simulator. If you'd like to simulate the early logic (pre-FPGA), [follow these steps](/docs/early-sim.md).

