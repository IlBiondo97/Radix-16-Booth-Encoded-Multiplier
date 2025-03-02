/**
 * @package mul_pkg.sv
 * @brief Package with useful parameter for the multiplier.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

 localparam int WIDTH = 52; // Width of the operands, change to adapt to your needs

 package mul_pkg;
    typedef enum logic [3:0] {
        PP_0,
        PP_A,
        PP_2A,
        PP_3A,
        PP_4A,
        PP_5A,
        PP_6A,
        PP_7A,
        PP_8A
     } booth_sel_t;
 endpackage
