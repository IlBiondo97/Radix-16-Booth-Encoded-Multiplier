# Radix-16 Multiplier with Booth Encoding Based on CSA

## Project Description

This project implements a high-speed multiplier based on the Booth algorithm with Radix-16 encoding, reducing the number of partial sums, and utilizes a Carry-Save Adder (CSA) structure to optimize the latency. The design is intended to improve performance compared to traditional multipliers by reducing the number of required operations. This multiplier can be used in Floating Point Units (FPU) that comply with the IEEE-754 Double Precision standard.

## Schematic

![Multiplier Schematic](/docs/schematic.svg)

## Repository Structure

The repository is organized as follows:

```
Radix-16-Booth-Encoded-Multiplier/
|── common/
|   |── counter.sv               # Counter module to count the clock cycles required for multiplication 
│   │── csa.sv                   # Carry-Save Adder module
|   |── FA.sv                    # Full-adder
│   |── rounder.sv               # Module for the Rounding to nearest even
|
|── docs/
|   |── schematic.svg            # Multiplier Schematic
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
|
|── sw/
|   |──init_sim.py               # Python script to set directory and initialize simulation
|   |──test_mul.do               # Do script to execute the simulation on Questasim simulator and save waves into vcd file
│
│── tb/                          # SystemVerilog testbench code
│   │── mul_tb.sv                # Testbench for the Multiplier
|
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

2. Ensure you have the Questasim development environment.
3. Run the `init_sim.py` script, located in the `sw` directory, using:

   ```sh
   python ./init_sim.py
   ```

4. Analyze the simulation results contained in the `test_mul.vcd` file, located in the `waves` directory, using any waveform viewer.

## Contributions

If you wish to contribute to the project, you can open a pull request or report an issue via the "Issues" section on GitHub.

## License

This project is distributed under the MIT license. See the `LICENSE` file for more details.

---

**Author:** [IlBiondo97]  
**GitHub:** [https://github.com/IlBiondo97]
