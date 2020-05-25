OPENQASM 2.0;
include "qelib1.inc";

// computes in[0] = 1 IOR in[1] = 1 
// stores the value in in[2];

qreg in[3];
creg out[3];

barrier in;

cx in[0], in[2];
cx in[1], in[2];
ccx in[0], in[1], in[2];

measure in -> out;