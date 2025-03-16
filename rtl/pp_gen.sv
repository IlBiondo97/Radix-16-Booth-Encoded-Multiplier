/**
 * @file pp_gen.sv
 * @brief Generate partial products based on the Booth Encoding.
 *
 * @author Ivan Biundo
 * @date 02/03/2025
 */

import mul_pkg::*;

module pp_gen (
    input logic signed [WIDTH-1:0] multiplicand_in,
    input booth_sel_t booth_sel,
    input logic neg_value,
    output logic signed [WIDTH+2:0] pp_out
);

  logic signed [WIDTH-1:0] not_PP;
  logic signed [WIDTH:0] PP_2, not_PP_2;
  logic signed [WIDTH+1:0] PP_3, PP_4, not_PP_3, not_PP_4;
  logic signed [WIDTH+2:0] PP_5, PP_6, PP_7, PP_8, not_PP_5, not_PP_6, not_PP_7, not_PP_8;

  always_comb begin

    // Generate partial products
    not_PP = ~multiplicand_in + 1;
    PP_2 = multiplicand_in << 1;
    not_PP_2 = ~PP_2 + 1;
    PP_3 = PP_2 + multiplicand_in;
    not_PP_3 = ~PP_3 + 1;
    PP_4 = multiplicand_in << 2;
    not_PP_4 = ~PP_4 + 1;
    PP_5 = PP_4 + multiplicand_in;
    not_PP_5 = ~PP_5 + 1;
    PP_6 = PP_4 + PP_2;
    not_PP_6 = ~PP_6 + 1;
    PP_7 = PP_4 + PP_3;
    not_PP_7 = ~PP_7 + 1;
    PP_8 = multiplicand_in << 3;
    not_PP_8 = ~PP_8 + 1;

    case ({booth_sel, neg_value})
      {PP_0, 1'b0}, {PP_0, 1'b1} : pp_out = 'h0;
      {PP_A, 1'b0} : pp_out = {{3{multiplicand_in[WIDTH-1]}}, multiplicand_in};
      {PP_2A, 1'b0} : pp_out = {{2{PP_2[WIDTH]}}, PP_2};
      {PP_3A, 1'b0} : pp_out = {PP_3[WIDTH+1], PP_3};
      {PP_4A, 1'b0} : pp_out = {PP_4[WIDTH+1], PP_4};
      {PP_5A, 1'b0} : pp_out = PP_5;
      {PP_6A, 1'b0} : pp_out = PP_6;
      {PP_7A, 1'b0} : pp_out = PP_7;
      {PP_8A, 1'b0} : pp_out = PP_8;
      {PP_A, 1'b1} : pp_out = {{3{not_PP[WIDTH-1]}}, not_PP};
      {PP_2A, 1'b1} : pp_out = {{2{not_PP_2[WIDTH]}}, not_PP_2};
      {PP_3A, 1'b1} : pp_out = {not_PP_3[WIDTH+1], not_PP_3};
      {PP_4A, 1'b1} : pp_out = {not_PP_4[WIDTH+1], not_PP_4};
      {PP_5A, 1'b1} : pp_out = not_PP_5;
      {PP_6A, 1'b1} : pp_out = not_PP_6;
      {PP_7A, 1'b1} : pp_out = not_PP_7;
      {PP_8A, 1'b1} : pp_out = not_PP_8;
      default: pp_out = 'h0;
    endcase
  end

endmodule
