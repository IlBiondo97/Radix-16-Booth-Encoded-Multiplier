import os

print("Creating Directory for simulation")

directory = "waves"
parent_dir = "../"

path = os.path.join(parent_dir, directory)
os.makedirs(path, exist_ok=True)  # Create waves directory for the vcd file

directory = "sim"

path = os.path.join(parent_dir, directory)
os.makedirs(path, exist_ok=True)  # Create sim directory for the simulation files

print("Starting Questasim")

os.chdir("../sim")
os.system("vsim -do ../sw/test_mul.do")  # Start Questasim simulator using a DO script file
