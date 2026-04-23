# 05. Multiplier

This project contains the development and functional verification of a 32-bit handshake-based multiplier designed for integration into a pipelined RISC-V processor. The repository combines RTL, basic simulation environments, and a UVM verification flow focused on validating arithmetic correctness, protocol behavior, and support for the four multiplication instructions of the RISC-V `M` extension.

## Objective

The goal of this project is to verify a multiplier architecture that supports:

- `MUL`
- `MULH`
- `MULHSU`
- `MULHU`
- ready/valid handshake on both input and output sides
- correct extraction of either lower or upper product bits depending on the selected operation

The main verification emphasis in this project is the UVM environment located in `tb/uvm/MULT/tb_c`.

## Directory Structure

```text
05.Muliplier/
├── rtl/
│   ├── core-related files
│   └── Type_M_Instructions/MULT_HANDSHAKE/
│       ├── rtl/
│       │   ├── multiplier.sv
│       │   └── multtulio.sv
│       ├── tb/
│       └── README.md
├── tb/
│   ├── basic_tb/
│   ├── rvvi/
│   └── uvm/
│       └── MULT/
│           ├── bvm/
│           └── tb_c/
└── uvm/
    └── MULT_HANDSHAKE/
```

## DUT Summary

The UVM environment verifies the DUT `multiplier_32x32`, instantiated in [top.sv](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/top.sv) and implemented in [multiplier.sv](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/rtl/Type_M_Instructions/MULT_HANDSHAKE/rtl/multiplier.sv).

### Main Inputs

- `clk`: main clock
- `rst_n`: active-low reset
- `a`: first 32-bit operand
- `b`: second 32-bit operand
- `in_valid_i`: input transaction valid
- `op_sel[1:0]`: selects the RISC-V multiplication variant
- `out_ready_i`: output ready handshake

### Main Outputs

- `resultado[31:0]`: multiplication result slice selected by `op_sel`
- `in_ready_o`: DUT ready to accept a new input
- `out_valid_o`: output result valid

## Supported Operations

The multiplier supports the four arithmetic variants of the RISC-V `M` extension:

| `op_sel` | Instruction | Operand Interpretation | Returned Bits |
| -------: | ----------- | ---------------------- | ------------- |
| `00` | `MUL` | signed x signed | lower 32 bits |
| `01` | `MULH` | signed x signed | upper 32 bits |
| `10` | `MULHSU` | signed x unsigned | upper 32 bits |
| `11` | `MULHU` | unsigned x unsigned | upper 32 bits |

## UVM Verification Environment

The UVM testbench is implemented in `tb/uvm/MULT/tb_c` and follows a self-checking architecture based on agents, monitors, a reference model, coverage collectors, and a comparator.

### Verification Architecture

- `agent_in`: drives and monitors input transactions
- `agent_out`: handles output-side handshake and result observation
- `refmod`: computes the expected result according to `op_sel`
- `bvm_comparator`: compares DUT output against the reference output
- `coverage_in`: collects input-space functional coverage
- `coverage_out`: collects output-space functional coverage

The input monitor forwards transactions to both coverage and the reference model. The reference model computes the golden result and sends it to the comparator, while the output monitor captures the DUT response and sends it to the same comparator. This structure provides a reusable and scalable self-checking flow.

## Verification Plan

The verification plan was built to validate arithmetic correctness, instruction decoding behavior, and handshake integrity under constrained-random stimulus.

### 1. Protocol Verification

The UVM drivers and monitors check the ready/valid behavior of the multiplier:

- input capture occurs when `in_valid_i && in_ready_o`
- output collection occurs when `out_valid_o && out_ready_i`
- reset handling is explicitly modeled in both input and output drivers

This ensures the DUT is not only mathematically correct, but also integration-safe for pipeline or coprocessor-style use.

### 2. Arithmetic Verification

The reference model in [refmod.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/refmod.svh) generates expected outputs for all four operations:

- `MUL`: lower 32 bits of signed multiplication
- `MULH`: upper 32 bits of signed multiplication
- `MULHSU`: upper 32 bits of signed x unsigned multiplication
- `MULHU`: upper 32 bits of unsigned multiplication

This is especially important because the same pair of 32-bit operands can produce different architecturally visible results depending on sign interpretation and selected slice of the 64-bit product.

### 3. Stimulus Strategy

The main test class `test` starts a single `in_sequence`, which mixes random transactions with directed constrained items. The generated scenarios include:

- low-range operand pairs
- high-range operand pairs
- operand `a == 0`
- operand `b == 0`
- operand `a == 1`
- operand `b == 1`
- both operands equal to zero
- random `op_sel` selection across all four RISC-V multiplication modes

This combination of broad randomization and targeted corner cases helps exercise zero products, identity behavior, sign-sensitive high-word extraction, and overflow-style product magnitudes.

### 4. Functional Coverage

Functional coverage confirms that both operand classes and instruction modes are being exercised.

#### Input Coverage

Implemented in [coverage_in.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/coverage_in.svh):

- bins for `a = 0`, `a = 1`, `a = 0xFFFFFFFF`, and medium values
- bins for `b = 0`, `b = 1`, `b = 0xFFFFFFFF`, and medium values
- low/high operand classification
- coverage of all `op_sel` values from `0` to `3`
- cross coverage between operand range and multiplication mode

#### Output Coverage

Implemented in [coverage_out.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/coverage_out.svh):

- zero results
- positive results
- negative results

## Why This Multiplier Is Interesting

One nice architectural detail in this project is that the same internal 64-bit multiplication engine supports four different ISA-visible instructions just by changing:

- how operands are interpreted as signed or unsigned
- which 32-bit slice of the full product is returned

That makes the verification effort more interesting than a simple `a * b` check. The real challenge is proving that operand signedness and result slicing remain consistent across all instruction variants, especially in corner cases where the upper 32 bits are the architecturally relevant data.

## Main Verification Files

- [test_pkg.sv](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/test_pkg.sv)
- [test.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/test.svh)
- [env.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/env.svh)
- [sequence.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/sequence.svh)
- [trans.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/trans.svh)
- [driver.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/driver.svh)
- [monitor.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/monitor.svh)
- [refmod.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/refmod.svh)
- [coverage_in.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/coverage_in.svh)
- [coverage_out.svh](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/tb/uvm/MULT/tb_c/coverage_out.svh)

## How To Run

From:

```bash
cd UVM/05.Muliplier/tb/uvm/MULT/tb_c
```

Run simulation:

```bash
make sim
```

Open waveforms:

```bash
make wave
```

Open coverage database:

```bash
make cover
```

Clean generated files:

```bash
make clean
```

## Tools

This environment was prepared for a Cadence-based flow:

- Xcelium / `xrun`
- SimVision
- IMC

The verification code also uses UVM and Brazil-IP BVM helper components.

## Verification Outcome

This project combines:

- handshake-aware UVM stimulus
- reference-model-based checking
- instruction-aware result validation
- functional coverage for operands and operation selection
- constrained-random and corner-case stimulus generation

As a result, the environment is well suited to validate both the arithmetic behavior of the multiplier and its processor-facing interface behavior before integration into a larger RISC-V execution pipeline.
