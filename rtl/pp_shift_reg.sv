/**
 * @file shift_reg.sv
 * @brief Shift register with parameterized width.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */
module pp_shift_reg #(
    parameter WIDTH = 8
) (
    input logic clk,
    input logic rst_n,
    input logic [(WIDTH/2)-1:0] din,
    output logic [(WIDTH/2)-1:0] dout
);
  reg [WIDTH-1:0] pp;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      pp <= 'h0;
    end else begin
      pp <= {4'(din[(WIDTH/2)-1]), din, pp[WIDTH/2-1:WIDTH/2-4]};
    end
  end
  assign dout = pp[WIDTH-1:WIDTH/2];
endmodule
