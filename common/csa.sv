/**
 * @csa.sv
 * @brief Carry Save Adder.
 *
 * @author Ivan Biundo
 * @date 03/03/2025
 */

module csa #(
    parameter int WIDTH = 8
)(
    input  logic [WIDTH+2:0] multiplicand_in,
    input  logic [WIDTH+2:0] pp_in,
    input  logic [WIDTH+2:0] carry_in,
    output logic [WIDTH+2:0] sum_out,
    output logic [WIDTH+2:0] carry_out
);

  generate
    for (genvar i = 0; i < WIDTH + 3; i++) begin : g_FA_instantiation
      FA fa_[i] (
          .a(multiplicand_in[i]),
          .b(pp_in[i]),
          .cin(carry_in[i]),
          .sum(sum_out[i]),
          .cout(carry_out[i])
      );
    end
  endgenerate

endmodule
