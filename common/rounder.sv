/**
 * @rounder.sv
 * @brief Module performing Rounding to nearest even.
 *
 * @author Ivan Biundo
 * @date 07/03/2025
 */

module rounder #(
    parameter int WIDTH = 8
) (
    input logic [(WIDTH<<1)-1:0] in,
    output logic [WIDTH-1:0] out
);

  always_comb begin
    if (in[WIDTH-1] == 1'b0) out = in[(WIDTH<<1)-1:WIDTH];
    else begin
      if (in[WIDTH-2:0] != {(WIDTH - 1) {1'b0}}) begin
        out = in[(WIDTH<<1)-1:WIDTH] + 1;
      end else begin
        if (in[WIDTH] == 1'b1) out = in[(WIDTH<<1)-1:WIDTH] + 1;
        else out = in[(WIDTH<<1)-1:WIDTH];
      end
    end
  end
endmodule
