/**
 * @counter.sv
 * @brief Counter module, generate a done signal when the multiplication is complete.
 *
 * @author Ivan Biundo
 * @date 08/03/2025
 */

 import mul_pkg::*;

module counter #(
    parameter int WIDTH = 4
)(
    input  logic clk,
    input  logic rst_n,
    input  logic start,
    output logic done
);

  logic [WIDTH-1:0] counter;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 'h0;
      done <= 1'b0;
    end else begin
      if (start) begin
        counter <= 'h0;
      end else begin
        counter <= counter + 'b1;
      end
    end
  end
  assign done = (counter == logic'(MULCYCLES) + 'b1) ? 1'b1 : 1'b0;
endmodule

