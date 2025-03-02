/**
 * @file booth_encoder.sv
 * @brief Encoder for the Booth Encoding, working on 5 bits.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

import mul_pkg::*;

module booth_encoder (
    input logic [4:0] multiplier_in,
    output booth_sel_t pp_sel, // partial product selection
    output logic neg // negative partial product
);

  always_comb begin
    // Generate partial products
    neg = multiplier_in[4];

    unique case (multiplier_in)
      5'b00000: pp_sel = PP_0;
      5'b00001: pp_sel = PP_A;
      5'b00010: pp_sel = PP_A;
      5'b00011: pp_sel = PP_2A;
      5'b00100: pp_sel = PP_2A;
      5'b00101: pp_sel = PP_3A;
      5'b00110: pp_sel = PP_3A;
      5'b00111: pp_sel = PP_4A;
      5'b01000: pp_sel = PP_4A;
      5'b01001: pp_sel = PP_5A;
      5'b01010: pp_sel = PP_5A;
      5'b01011: pp_sel = PP_6A;
      5'b01100: pp_sel = PP_6A;
      5'b01101: pp_sel = PP_7A;
      5'b01110: pp_sel = PP_7A;
      5'b01111: pp_sel = PP_8A;
      5'b10000: pp_sel = PP_8A;
      5'b10001: pp_sel = PP_7A;
      5'b10010: pp_sel = PP_7A;
      5'b10011: pp_sel = PP_6A;
      5'b10100: pp_sel = PP_6A;
      5'b10101: pp_sel = PP_5A;
      5'b10110: pp_sel = PP_5A;
      5'b10111: pp_sel = PP_4A;
      5'b11000: pp_sel = PP_4A;
      5'b11001: pp_sel = PP_3A;
      5'b11010: pp_sel = PP_3A;
      5'b11011: pp_sel = PP_2A;
      5'b11100: pp_sel = PP_2A;
      5'b11101: pp_sel = PP_A;
      5'b11110: pp_sel = PP_A;
      5'b11111: pp_sel = PP_0;
      default:  pp_sel = PP_0;
    endcase
  end
endmodule
