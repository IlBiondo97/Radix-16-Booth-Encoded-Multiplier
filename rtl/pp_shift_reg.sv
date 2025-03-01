/**
 * @file pp_shift_reg.sv
 * @brief Shift register with parameterized width for partial products.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */
module pp_shift_reg #(
    parameter int WIDTH = 8
) (
    input  logic clk,
    input  logic rst_n,
    input  logic load,
    input  logic [(WIDTH/2)-1:0] din,
    output logic [(WIDTH/2)-1:0] dout
);
  reg [WIDTH-1:0] pp;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      pp <= 'h0;
    end else begin
      if (load) pp <= 'h0;
      else pp <= {{4{din[(WIDTH/2)-1]}}, din, pp[WIDTH/2-1:4]};
    end
  end
  assign dout = pp[WIDTH-1:WIDTH/2];
endmodule
