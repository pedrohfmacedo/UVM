// The collection of signal ports for DUT and testbench
interface a_if (input logic clock, reset);

  logic valid; // handshake signal: a is valid at rising clock when valid=1
  logic [7:0] a, a2, a3, a4, a5, a6, a7, a8; // not using parameter to keep it simpler

  // The interface input port is for incoming data.
  modport inp (input clock, reset, input valid, input a, a2, a3, a4, a5, a6, a7, a8);

  // The interface output port is for outcoming data.
  modport outp (input clock, reset, output valid, output a, a2, a3, a4, a5, a6, a7, a8);

endinterface

