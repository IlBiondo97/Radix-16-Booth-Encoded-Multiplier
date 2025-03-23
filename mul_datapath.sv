/**
 * @file mul_datapath.sv
 * @brief Datapath of the Multiplier.
 *
 * @author Ivan Biundo
 * @date 07/03/2025
 */

import mul_pkg::*;

module mul_datapath (
    input logic clk,
    input logic rst_n,
    input logic start,
    input logic signed [WIDTH-1:0] multiplicand_i,
    input logic signed [WIDTH-1:0] multiplier_i,
    output logic signed [(WIDTH<<1)-1:0] product_o,
    output logic signed [WIDTH-1:0] product_rounded_o,
    output logic done
);

  // Internal signals
  logic signed [WIDTH<<1:0] sum_out;
  logic [(WIDTH<<1)-1:0] pp_shift_reg_q, carry_shift_reg_q;
  logic signed [WIDTH+2:0] pp_gen_q, pp_shift_reg_d, carry_shift_reg_d;
  logic signed [WIDTH-1:0]
      multiplicand_reg_out_q, product_rounded_d;
  logic last_bit_q, neg_sign_int;
  booth_sel_t pp_sel_int;

  multiplicand_reg multiplicand_reg_instance (
      .clk  (clk),
      .rst_n(rst_n),
      .load (start),
      .din  (multiplicand_i),
      .dout (multiplicand_reg_out_q)
  );

  pp_gen pp_gen_instance (
      .multiplicand_in(multiplicand_reg_out_q),
      .booth_sel(pp_sel_int),
      .neg_value(neg_sign_int),
      .pp_out(pp_gen_q)
  );

  booth_encoder booth_encoder_instance (
      .multiplier_in({pp_shift_reg_q[3:0], last_bit_q}),
      .pp_sel(pp_sel_int),
      .neg(neg_sign_int)
  );

  pp_carry_shift_reg pp_carry_shift_reg_instance (
      .clk(clk),
      .rst_n(rst_n),
      .load(start),
      .pp_din(pp_shift_reg_d),
      .carry_din(carry_shift_reg_d),
      .multiplier_in(multiplier_i),
      .pp_dout(pp_shift_reg_q),
      .carry_dout(carry_shift_reg_q),
      .last_bit(last_bit_q)
  );

  csa #(
      .WIDTH(WIDTH)
  ) csa_instance (
      .multiplicand_in(pp_gen_q),
      .pp_in({{3{pp_shift_reg_q[(WIDTH<<1)-1]}}, pp_shift_reg_q[(WIDTH<<1)-1:WIDTH]}),
      .carry_in({{3{carry_shift_reg_q[(WIDTH<<1)-1]}}, carry_shift_reg_q[(WIDTH<<1)-1:WIDTH]}),
      .sum_out(pp_shift_reg_d),
      .carry_out(carry_shift_reg_d)
  );

  assign sum_out = carry_shift_reg_q + pp_shift_reg_q;

  // Instantiantion of rounder module or not, depending on the FpuMultiplier parameter
  generate
    if (FpuMultiplier) begin : g_rounded_output_for_fpu
      rounder #(
          .WIDTH(WIDTH)
      ) rounder_instance (
          .in (sum_out[(WIDTH<<1)-1:0]),
          .out(product_rounded_d)
      );

      // Output register
      logic [WIDTH-1:0] product_rounded_q;

      always_ff @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
              product_rounded_q <= 'h0;
            end else begin
                product_rounded_q <= product_rounded_d;
            end
        end
        assign product_rounded_o = product_rounded_q;
        assign product_o = 'h0;
    end else begin : g_normal_output

        // Output register
        logic [(WIDTH<<1)-1:0] product_q;
        always_ff @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                product_q <= 'h0;
            end else begin
                product_q <= sum_out[(WIDTH<<1)-1:0];
            end
        end
      assign product_o = product_q;
      assign product_rounded_o = 'h0;
    end
  endgenerate

counter # (
    .WIDTH(COUNTERWIDTH)
) counter_instance(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .done(done)
);
endmodule
