## Clock (125 MHz)
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
# create_clock -name sys_clk -period 8.0 [get_ports clk]

## Buttons (momentary)

## BTN3
set_property PACKAGE_PIN Y16 [get_ports coin_10] 
set_property IOSTANDARD LVCMOS33 [get_ports coin_10]

## BTN2
set_property PACKAGE_PIN K19 [get_ports coin_25]
set_property IOSTANDARD LVCMOS33 [get_ports coin_25]

## BTN1
set_property PACKAGE_PIN P16 [get_ports next_item] 
set_property IOSTANDARD LVCMOS33 [get_ports next_item]

## BTN0
set_property PACKAGE_PIN K18 [get_ports select]
set_property IOSTANDARD LVCMOS33 [get_ports select]

## LED Output
set_property PACKAGE_PIN M14 [get_ports dispense]
set_property IOSTANDARD LVCMOS33 [get_ports dispense]

## HDMI output pins
## blue
set_property PACKAGE_PIN D19    [get_ports HDMI_TX_B_P]
set_property PACKAGE_PIN D20    [get_ports HDMI_TX_B_N]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_B_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_B_N]

## green
set_property PACKAGE_PIN C20    [get_ports HDMI_TX_G_P]
set_property PACKAGE_PIN B20    [get_ports HDMI_TX_G_N]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_G_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_G_N]
## red
set_property PACKAGE_PIN B19    [get_ports HDMI_TX_R_P]
set_property PACKAGE_PIN A20    [get_ports HDMI_TX_R_N]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_R_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_R_N]

## TMDS clock
set_property PACKAGE_PIN H16    [get_ports HDMI_TX_CLK_P]
set_property PACKAGE_PIN H17    [get_ports HDMI_TX_CLK_N]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_CLK_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_TX_CLK_N]