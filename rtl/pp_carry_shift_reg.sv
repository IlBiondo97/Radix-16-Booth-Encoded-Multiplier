/**
 * @file pp_shift_reg.sv
 * @brief Shift register with parameterized width for partial products and carries.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

import mul_pkg::*;
module pp_carry_shift_reg (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [WIDTH+2:0] pp_din,
    input logic [WIDTH+2:0] carry_din,
    output logic [(WIDTH<<1)-1:0] pp_dout,
    output logic [(WIDTH<<1)-1:0] carry_dout
);
  reg [(WIDTH<<1)-1:0] pp;  //TODO: Unify pp and multiplier registers to optimize area
  reg [(WIDTH<<1)-1:0] carry;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      pp <= 'h0;
      carry <= 'h0;
    end else begin
      if (load) begin
        pp <= 'h0;
        carry <= 'h0;
      end else begin
        pp <= {pp_din[WIDTH-1], pp_din, pp[WIDTH-1:4]};
        carry <= {carry_din, 1'b0, carry[WIDTH-1:4]};
      end
    end
  end
  assign pp_dout = pp;
  assign carry_dout = carry;
endmodule
