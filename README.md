# RISC-V Single Cycle Processor (RV32I) - Verilog Implementation
This repository contains the Verilog design, testbenches, and simulation files for a modular, single-cycle RISC-V processor implementing the RV32I base instruction set architecture.

The project was developed as part of my internship at Solid State Physics Laboratory (SSPL), Defence Research and Development Organisation (DRDO), Delhi, and as a part of academic learning at National Institute of Technology, Raipur.

📦 Repository Contents
  ● src/ — All Verilog source files for the processor design.
  ● tb/ — Testbenches for individual modules and the top-level processor.
  ●📄 Documentation
  For a comprehensive explanation of the architecture, design approach, instruction set, and defence applications of this project, refer to:
    >Divyanshi_RISC-V.pdf — 📄 Detailed presentation explaining the complete design, datapath, instruction set, execution flow, and defence applications.
    >schematic.pdf — 🗂️ Schematic diagram of the complete top-level processor generated from Vivado.
● README.md — This file.

⚙️ Project Highlights
✅ Complete Verilog implementation of a single-cycle RV32I processor
✅ Modular design with clean separation of datapath and control logic
✅ Simulation and verification using Icarus Verilog and GTKWave
✅ Hardware schematic generated using Xilinx Vivado
✅ Detailed presentation explaining processor architecture, execution flow, and defence relevance

📊 Features
Implements all 47 RV32I instructions:
Arithmetic, Logic, Load/Store, Branch, Jump, Immediate instructions
Supports:
Instruction Memory
Data Memory
32 General-Purpose Registers
Immediate Generator
ALU with Control Logic
Suitable for academic and research purposes

🛠 Tools Used
Verilog HDL
Icarus Verilog — Simulation
GTKWave — Waveform visualization
Xilinx Vivado — RTL analysis, Schematic generation
