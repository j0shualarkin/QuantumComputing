OPENQASM 2.0;
include "qelib1.inc";

qreg in[3];
creg out[3];

barrier in;

ccx in[0], in[1], in[2];
ccx in[0], in[2], in[1];
ccx in[0], in[1], in[2];

measure in -> out;