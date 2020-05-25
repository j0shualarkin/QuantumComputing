OPENQASM 2.0;
include "qelib1.inc";

qreg in[2];
creg out[2];

barrier in;

cx in[0], in[1];
cx in[1], in[0];
cx in[0], in[1];

measure in -> out;