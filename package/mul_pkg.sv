/**
 * @package mul_pkg.sv
 * @brief Package with useful parameter for the multiplier.
 *
 * @author Ivan Biundo
 * @date 01/03/2025
 */

 package mul_pkg;
    typedef enum logic [4:0] {
        PP_0,
        PP_A,
        PP_2A,
        PP_3A,
        PP_4A,
        PP_5A,
        PP_6A,
        PP_7A,
        PP_8A,
        PP_not8A,
        PP_not7A,
        PP_not6A,
        PP_not5A,
        PP_not4A,
        PP_not3A,
        PP_not2A,
        PP_notA
     } booth_sel_t;
 endpackage
