# Radix-16 Multiplier with Booth Encoding Based on CSA

## Project Description
This project implements a high-speed multiplier based on the Booth algorithm with Radix-16 encoding, reducing the number of partial sums, and utilizes a Carry-Save Adder (CSA) structure to optimize the latency. The design is intended to improve performance compared to traditional multipliers by reducing the number of required operations. This multiplier can be used in Floating Point Units (FPU) that comply with the IEEE-754 Double Precision standard.

## Repository Structure
The repository is organized as follows:

```
Radix-16-Booth-Encoded-Multiplier/
|── common/
|   |── FA.sv                    # Full-adder
│   │── csa.sv                   # Carry-Save Adder module
│   |── rounder.sv               # Module for the Rounding to nearest even
|
│── package/                     # Packages and definitions used in the project
│   │── mul_pkg.sv               # Definitions for the Multiplicator module
|      
│── rtl/                         # SystemVerilog source code
│   │── booth_encoder.sv         # Booth Radix-16 encoding module
│   │── multiplicand_reg.sv      # Register for the Multiplicand operand
|   |── multiplier_shift_reg.sv  # Shift register for the Multiplier operand
|   |── pp_carry_shift_reg.sv    # Shift register for partial products and carries
|   |── pp_gen.sv                # Partial products generator module
│
│── .gitignore                   # File to exclude specific files from versioning
│── LICENSE                      # Project license (MIT)
|── mul_datapath.sv              # Multiplier Datapath
│── README.md                    # This file
```

## Installation and Usage
1. Clone the repository:
   ```sh
   git clone https://github.com/IlBiondo97/Radix-16-Booth-Encoded-Multiplier.git
   ```
2. Open the project in a SystemVerilog-compatible development environment.
3. Compile and simulate the project using the provided testbenches (to be implemented).
4. Analyze the simulation results to verify the correct operation of the multiplier.

## Contributions
If you wish to contribute to the project, you can open a pull request or report an issue via the "Issues" section on GitHub.

## License
This project is distributed under the MIT license. See the `LICENSE` file for more details.

---

**Author:** [IlBiondo97]  
**GitHub:** [https://github.com/IlBiondo97]