/**
 * @file multiplicand_reg.sv
 * @brief register with parameterized width for multiplicand.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

 import mul_pkg::*;

 module multiplicand_reg (
     input  logic clk,
     input  logic rst_n,
     input  logic load,
     input  logic signed [WIDTH-1:0] din,
     output logic signed [WIDTH-1:0] dout
 );
   reg signed [WIDTH-1:0] multiplicand;

   always_ff @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
       multiplicand <= 'h0;
     end else begin
         if (load) multiplicand <= din;
         else multiplicand <= multiplicand;
     end
   end
   assign dout = multiplicand;
endmodule
