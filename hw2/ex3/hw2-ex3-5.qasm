OPENQASM 2.0;
include "qelib1.inc";

// Design a 3-bit reversible circuit 
// which swaps 000 and 111 and leaves other inputs fixed 

qreg in[3];
creg out[3];

barrier in;

ccx in[0], in[1], in[2];
ccx in[0], in[2], in[1];
ccx in[1], in[2], in[0];
ccx in[0], in[2], in[1];

cx  in[0], in[2];
cx  in[1], in[2];
cx  in[2], in[1];
cx  in[2], in[0];

ccx in[0], in[1], in[2];

x in;

measure in -> out;
