module retro_top (
  input clk,
  input coin_10,
  input coin_25,
  input next_item,
  input select,
  output wire dispense
);

wire reset;

//HDMI Implementation
wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;
wire h_sync;
wire v_sync;
wire tmds_blue;
wire tmds_green;
wire tmds_red;

clk_wiz_0 instance_name
   (
    .clk_25mhz(clk_25mhz),     
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

// HDMI Implementation

hdmi_core hdmi (
  .clk(clk_25mhz),
  .reset(reset),
  .red(red),
  .green(green),
  .blue(blue),
  .h_sync(h_sync),
  .v_sync(v_sync)
);

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

endmodule
