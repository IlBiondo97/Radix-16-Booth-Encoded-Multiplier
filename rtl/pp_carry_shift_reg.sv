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
    input logic [WIDTH-1:0] multiplier_in,
    output logic [(WIDTH<<1)-1:0] pp_dout,
    output logic [(WIDTH<<1)-1:0] carry_dout,
    output logic last_bit
);
  reg [(WIDTH<<1)-1:0] pp;  //TODO: Unify pp and multiplier registers to optimize area
  reg [(WIDTH<<1)-1:0] carry;
  reg last_bit_reg;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      pp <= 'h0;
      carry <= 'h0;
      last_bit_reg <= 1'b0;
    end else begin
      if (load) begin
        pp <= {{WIDTH{1'b0}}, multiplier_in};
        carry <= 'h0;
        last_bit_reg <= 1'b0;
      end else begin
        pp <= {pp_din[WIDTH+2], pp_din, pp[WIDTH-1:4]};
        carry <= {carry_din, 1'b0, carry[WIDTH-1:4]};
        last_bit_reg <= pp[3];
      end
    end
  end
  assign pp_dout = pp;
  assign carry_dout = carry;
  assign last_bit = last_bit_reg;
endmodule
