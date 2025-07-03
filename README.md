### Retro Vending Machine
A hardware-synthesizable vending machine designed using Verilog and SystemVerilog, featuring a finite state machine, debounced inputs, and HDMI-based video output. Designed for simulation, synthesis, and deployment on the Zybo Z7 FPGA board.

**Tools Used**

`Xilinx Vivado`
`Verilog/SystemVerilog`
`Icarus Verilog 12.0`
`GTKWave`
`Visual Studio Code`
`Git`

---

#### **Learning Objectives**

- **FSM Implementation** – Designed and verified a hardware finite state machine (FSM) with well-defined states and transitions
- **Debouncing I/O** – Implemented hardware-synthesizable I/O management using debouncing and edge-detection to accurately register real-world inputs
- **Video Timing and Output** – Generated VGA signals and manually serialized and encoded data for HDMI output
- **Hardware Verification** – Used simulation testbenches and GTKWave for debugging

---

#### **File Structure**

`/docs` –> Extra documentation that you probably can't be bothered to read\
`/fpga` –> Current version of the project, FPGA implementation source code, top file, and Xilinx constraints\
`/src`  –> Legacy source code\
`/tb`   –> Legacy testbenches

---

#### **Project Timeline & Features**

| Timeline | Feature | Description |
|--------|-------------|--------|
| 6/25/2025 | FSM Architecture | With `IDLE`, `COLLECTING`, and `DISPENSING` states 
| 6/26/2025 | Debounced Inputs | Edge-triggered and debounced coin/button logic for clean signal processing and hardware synthesizability |
| 6/29/2025 | Item Selection & Change Return | Scrolling selector with item-price pairs; stores and returns change on dispense. | 
| 7/1/2025 | Initial FPGA Deployment | Synthesis, implementation, constraints, and top-level wiring completed; bitstream flashed for onboard I/O demo |
| 7/2/2025| HDMI Video Output | TMDS-encoded and serial differential video output over HDMI, simple bitmapped pixel text outputs |

\
*Planned Features* 
| Feature | Description |
|--------|-------------|
| Logic Improvements | Add more states/state interrupts and visual output for those states to indicate selected items, etc. |
| Visual Improvements | Increase text size for readability, add more UI elements if wanted

---

#### **Demos**

[**Initial RTL verification**](https://youtu.be/YAWXXol3p50?si=UQe-jVr7k9robtwH) –
Uses on-board I/O to verify RTL; demonstrates that debouncer responds well to real-world button inputs\
[**HDMI Output and Pixel Text**](https://youtu.be/nstLu7CKKXI?si=7paIRkDUl7c_qRaL) –
Demonstrates the results of my HDMI signal generation and interfacing, as well as some bitmapped text outputs


---
#### **Simulation (Legacy FSM)**
This project began as an RTL FSM simulator. If you'd like to simulate the early logic (pre-FPGA), [follow these steps](/docs/early-sim.md).

