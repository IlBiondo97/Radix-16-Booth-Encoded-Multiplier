/**
 * @file multiplier_shift_reg.sv
 * @brief Shift register with parameterized width for multiplier.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

 module multiplier_shift_reg #(
    parameter int WIDTH = 8
 )(
    input logic clk,
    input logic rst_n,
    input logic shift,
    input logic [WIDTH-1:0] din,
    output logic [3:0] dout,
    output logic last_bit
 );

    reg [WIDTH-1:0] multiplier;
    reg last_bit_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            multiplier <= 'h0;
            last_bit_reg <= 1'b0;
        end else begin
            if(shift) begin
                multiplier <= {4'b0, multiplier[WIDTH-1:4]};
                last_bit_reg <= multiplier[WIDTH/2-1];
            end else begin
                multiplier <= din;
                last_bit_reg <= 1'b0;
            end
        end
    end
    assign dout = multiplier[3:0];
    assign last_bit = last_bit_reg;
 endmodule
