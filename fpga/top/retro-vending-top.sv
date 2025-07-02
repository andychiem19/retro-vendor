module retro_top (
  input clk,
  input coin_10,
  input coin_25,
  input next_item,
  input select,
  output wire dispense,

  // OBUFDS HDMI Ports
  output wire HDMI_TX_R_P, HDMI_TX_R_N,
  output wire HDMI_TX_G_P, HDMI_TX_G_N,
  output wire HDMI_TX_B_P, HDMI_TX_B_N,
  output wire HDMI_TX_CLK_P, HDMI_TX_CLK_N
);

wire reset;

//HDMI Implementation Signals
wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;
wire h_sync, v_sync, video_on;
wire tmds_blue, tmds_green, tmds_red;
wire serial_red, serial_green, serial_blue;

//25 MHz pixel clock and 250 MHz clock to serialize 10-bit TMDS
clk_wiz_0 instance_name
   (
    .clk_25mhz(clk_25mhz),  
    .clk_250mhz(clk_250mhz),   
    .reset(reset), 
    .locked(locked),       
    .clk_in1(clk)     
);

startup_reset sr (
  .clk(clk),
  .reset(reset)
);

retro_vending rv (
    .clk(clk),
    .reset(reset),
    .coin_5(1'b0),
    .coin_10(coin_10),
    .coin_25(coin_25),
    .next_item(next_item),
    .select(select),
    .dispense(dispense),
    .change()
);

// HDMI Implementation Start

vga_generator vga (
  .clk_25mhz(clk_25mhz),
  .reset(reset),
  .red(red),
  .green(green),
  .blue(blue),
  .h_sync(h_sync),
  .v_sync(v_sync),
  .video_on(video_on)
);

//TMDS Encoders
tmds_encoder_dvi enc_red (
  .i_clk(clk_25mhz),
  .i_rst(reset),
  .i_data(red),
  .i_ctrl(2'b00),
  .i_de(video_on),
  .o_tmds(tmds_red)
);

tmds_encoder_dvi enc_green (
  .i_clk(clk_25mhz),
  .i_rst(reset),
  .i_data(green),
  .i_ctrl(2'b00),
  .i_de(video_on),
  .o_tmds(tmds_green)
);

tmds_encoder_dvi enc_blue (
  .i_clk(clk_25mhz),
  .i_rst(reset),
  .i_data(blue),
  .i_ctrl({v_sync, h_sync}),
  .i_de(video_on),
  .o_tmds(tmds_blue)
);

// TMDS Serializers
serializer srl_red (
  .clk_250mhz(clk_250mhz),
  .o_tmds(tmds_red),
  .serial_out(serial_red)
);

serializer srl_green (
  .clk_250mhz(clk_250mhz),
  .o_tmds(tmds_green),
  .serial_out(serial_green)
);

serializer srl_blue(
  .clk_250mhz(clk_250mhz),
  .o_tmds(tmds_blue),
  .serial_out(serial_blue)
);

// OBUFDS, turns single bit serial into differential pairs
// Red 
OBUFDS #(.IOSTANDARD("TMDS_33")) obuf_r (
  .I(serial_red),
  .O(HDMI_TX_R_P),
  .OB(HDMI_TX_R_N)
);

// Green 
OBUFDS #(.IOSTANDARD("TMDS_33")) obuf_g (
  .I(serial_green),
  .O(HDMI_TX_G_P),
  .OB(HDMI_TX_G_N)
);

// Blue 
OBUFDS #(.IOSTANDARD("TMDS_33")) obuf_b (
  .I(serial_blue),
  .O(HDMI_TX_B_P),
  .OB(HDMI_TX_B_N)
);

// TMDS clock 
OBUFDS #(.IOSTANDARD("TMDS_33")) obuf_clk (
  .I(clk_25mhz),
  .O(HDMI_TX_CLK_P),
  .OB(HDMI_TX_CLK_N)
);


endmodule
