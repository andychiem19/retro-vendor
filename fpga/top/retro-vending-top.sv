module retro_top (
  input clk,
  input coin_10,
  input coin_25,
  input next_item,
  input select,
  output wire dispense
);

wire reset;

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

endmodule