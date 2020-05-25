OPENQASM 2.0;
include "qelib1.inc";

// Design 3-bit reversible circuit
// swaps 000 and 001 

qreg i[3];
creg o[3];

barrier i;

ccx i[0], i[1], i[2];
cx i[0], i[2];
cx i[1], i[2];
x i[2];

// x i[2];
// cx i[1], i[2];
// cx i[0], i[2];
// ccx i[0], i[1], i[2];

measure i -> o;