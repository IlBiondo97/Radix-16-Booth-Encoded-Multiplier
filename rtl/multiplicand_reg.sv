/**
 * @file multiplicand_reg.sv
 * @brief register with parameterized width for multiplicand.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

 module multiplicand_reg #(
     parameter int WIDTH = 8
 ) (
     input  logic clk,
     input  logic rst_n,
     input  logic [WIDTH-1:0] din,
     output logic [WIDTH-1:0] dout
 );
   reg [WIDTH-1:0] multiplicand;

   always_ff @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
       multiplicand <= 'h0;
     end else begin
       multiplicand <= din;
     end
   end
   assign dout = multiplicand;
endmodule
