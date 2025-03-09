/**
 * @file mul_tb.sv
 * @brief Testbench for the multiplier.
 *
 * @author Ivan Biundo
 * @date 09/03/2025
 */

import mul_pkg::*;

module mul_tb;

  // Parameters
  localparam int ClkCycle = 10;

  // Signals
  logic clk, rst_n, start, done;
  logic [WIDTH-1:0] multiplicand_int, multiplier_int, product_rounded_int;
  logic [(WIDTH<<1)-1:0] product_int;

  always begin
    clk = ~clk;
    #(ClkCycle / 2);
  end

  initial begin
    if (!FpuMultiplier) begin
      $display("Starting testbench - Normal Multiplier");
      rst_n = 1'b0;  // reset active low
      #(ClkCycle * 5);
      $display("Reset deasserted");
      rst_n = 1'b1;  // deassert reset
      start = 1'b0;

      for (int i = 0; i < 100; i++) begin
        multiplicand_int =
            $urandom_range(0, (1 << WIDTH) - 1);  // random number between 0 and 2^WIDTH-1
        multiplier_int =
            $urandom_range(0, (1 << WIDTH) - 1);  // random number between 0 and 2^WIDTH-1
        start = 1'b1;
        #ClkCycle;
        start = 1'b0;
        #(ClkCycle * MULCYCLES);  // wait for the multiplication to complete
        assert (done == 1'b1)
          $display("Multiplication_[%d] done", i);  // check if the multiplication is done
        else $display("Multiplication_[%d] not done", i);
        assert (product_int == multiplicand_int * multiplier_int)  // check if the result is correct
          $display(
              "Multiplication_[%d] correct - result = %d multiplicand = %d multiplier = %d",
              i,
              product_int,
              multiplicand_int,
              multiplier_int
          );
        else
          $fatal(
              "Multiplication_[%d] incorrect - result = %d multiplicand = %d multiplier = %d",
              i,
              product_int,
              multiplicand_int,
              multiplier_int
          );
      end
    end else begin
      $display("Starting testbench - FPU Multiplier");
      rst_n = 1'b0;  // reset active low
      #(ClkCycle * 5);
      $display("Reset deasserted");
      rst_n = 1'b1;  // deassert reset
      start = 1'b0;

      for (int i = 0; i < 100; i++) begin
        multiplicand_int =
            $urandom_range(0, (1 << WIDTH) - 1);  // random number between 0 and 2^WIDTH-1
        multiplier_int =
            $urandom_range(0, (1 << WIDTH) - 1);  // random number between 0 and 2^WIDTH-1
        start = 1'b1;
        #ClkCycle;
        start = 1'b0;
        #(ClkCycle * MULCYCLES);  // wait for the multiplication to complete
        assert (done == 1'b1)
          $display("Multiplication_[%d] done", i);  // check if the multiplication is done
        else $display("Multiplication_[%d] not done", i);
        assert (product_rounded_int == rtne_on_k_bits(multiplicand_int*multiplier_int))  // check if the result is correct
          $display(
              "Multiplication_[%d] correct - result = %d result rounded by func = %d multiplicand = %d multiplier = %d",
              i,
              product_rounded_int,
              rtne_on_k_bits(multiplicand_int*multiplier_int),
              multiplicand_int,
              multiplier_int
          );
        else
          $fatal(
              "Multiplication_[%d] incorrect - result = %d result rounded by func = %d multiplicand = %d multiplier = %d",
              i,
              product_rounded_int,
              rtne_on_k_bits(multiplicand_int*multiplier_int),
              multiplicand_int,
              multiplier_int
          );
      end
    end
  end

  mul_datapath mul_datapath_instance (
      .clk(clk),
      .rst_n(rst_n),
      .start(start),
      .multiplicand_i(multiplicand_int),
      .multiplier_i(multiplier_int),
      .product_o(product_int),
      .product_rounded_o(product_rounded_int),
      .done(done)
  );

  function logic [WIDTH-1:0] rtne_on_k_bits(input logic [(WIDTH<<1)-1:0] data); // Rounding to nearest even on k bits receiving a 2k bits number
    if (data[WIDTH-1] == 1'b0) rtne_on_k_bits = data[(WIDTH<<1)-1:WIDTH];
    else begin
      if (data[WIDTH-2:0] != {(WIDTH - 1) {1'b0}}) begin
        rtne_on_k_bits = data[(WIDTH<<1)-1:WIDTH] + 1;
      end else begin
        if (data[WIDTH] == 1'b1) rtne_on_k_bits = data[(WIDTH<<1)-1:WIDTH] + 1;
        else rtne_on_k_bits = data[(WIDTH<<1)-1:WIDTH];
      end
    end
  endfunction

endmodule
