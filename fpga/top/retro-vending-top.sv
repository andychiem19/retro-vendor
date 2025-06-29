module retro_top (
  input clk,
  input coin_5,
  input coin_10,
  input coin_25,
  input next_item,
  input select,
  output wire dispense,
  output wire [7:0] change
);

wire reset;

startup_reset sr (
  .clk(clk),
  .reset(reset)
);

retro_vending rv (
    .clk(clk),
    .reset(reset),
    .coin_5(coin_5),
    .coin_10(coin_10),
    .coin_25(coin_25),
    .next_item(next_item),
    .select(select),
    .dispense(dispense),
    .change(change)
);

endmodule