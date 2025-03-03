/**
 * @file FA.sv
 * @brief Full Adder.
 *
 * @author Ivan Biundo
 * @date 02/03/2025
 */

 module FA (
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
 );

 assign sum = a ^ b ^ cin;
 assign cout = (a & b) | (cin & (a ^ b));
 endmodule
