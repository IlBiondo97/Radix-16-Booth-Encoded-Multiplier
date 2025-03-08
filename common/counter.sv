/**
 * @counter.sv
 * @brief Counter module, generate a done signal when the multiplication is complete.
 *
 * @author Ivan Biundo
 * @date 08/03/2025
 */

module counter (
    input  logic clk,
    input  logic rst_n,
    input  logic start,
    output logic done
);

  logic [3:0] counter;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 4'b0;
      done <= 1'b0;
    end else begin
      if (start) begin
        counter <= 4'b0;
      end else begin
        counter <= counter + 4'b0001;
      end
    end
  end
  assign done = (counter == 4'b1110) ? 1'b1 : 1'b0;
endmodule

