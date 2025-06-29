## Clock (125 MHz)
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name sys_clk -period 8.0 [get_ports clk]

## Buttons (momentary)
set_property PACKAGE_PIN Y16 [get_ports coin_10]
set_property IOSTANDARD LVCMOS33 [get_ports coin_10]

set_property PACKAGE_PIN K19 [get_ports coin_25]
set_property IOSTANDARD LVCMOS33 [get_ports coin_25]

set_property PACKAGE_PIN P16 [get_ports next_item] 
set_property IOSTANDARD LVCMOS33 [get_ports next_item]

set_property PACKAGE_PIN K18 [get_ports select]
set_property IOSTANDARD LVCMOS33 [get_ports select]

## LED Output
set_property PACKAGE_PIN M14 [get_ports dispense]
set_property IOSTANDARD LVCMOS33 [get_ports dispense]