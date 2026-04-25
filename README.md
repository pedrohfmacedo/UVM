# UVM

This repository contains hardware functional verification projects developed with SystemVerilog and UVM. The collection starts with smaller training exercises and grows into more complete verification environments for arithmetic blocks integrated into processor-oriented designs.

## Overview

The projects in this repository cover:

- reusable UVM environment structure
- basic verification exercises
- FSM verification
- data-path verification
- self-checking arithmetic verification with reference models and coverage

## Tools

- Cadence Xcelium / `xrun`
- SystemVerilog
- UVM
- Linux / Red Hat based development flow

## Projects

### 00. UVM

Introductory material and example project structure for learning and organizing UVM-based verification flows.

### 01. UVM_model

A generic UVM model intended as a reusable starting point for new verification environments.

### 02. Ordener

UVM verification project for an 8-input, 8-bit sorter, focused on checking ordered output behavior.

### 03. Sequence_identifier

UVM verification project for an FSM that detects the `0001` sequence, with emphasis on sequence-based control verification.

### 04. Divider_optimization

Verification of a handshake-based 32-bit divider with signed and unsigned operation support, reference-model checking, functional coverage, and UVM-based self-checking flow.

Detailed README:
[04.Divider_optimization/README.md](/home/xmen/Desktop/meu_git/UVM/04.Divider_optimization/README.md)

### 05. Muliplier

Verification of a handshake-based 32-bit multiplier supporting the RISC-V `M` extension multiplication variants `MUL`, `MULH`, `MULHSU`, and `MULHU`, using UVM agents, reference-model comparison, and coverage collection.

Detailed README:
[05.Muliplier/README.md](/home/xmen/Desktop/meu_git/UVM/05.Muliplier/README.md)

## Notes

The repository mixes learning-oriented projects and more complete block-level verification environments. As the project numbers increase, the environments become more structured and closer to practical verification flows used for processor and arithmetic IP development.
