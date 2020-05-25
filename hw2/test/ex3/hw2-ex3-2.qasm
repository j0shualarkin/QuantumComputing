OPENQASM 2.0;
include "qelib1.inc";

// 2-bit reversible circuit
// swaps 00 and 11, leaves other inputs fixed

qreg i[2];
creg o[2];

barrier i;

cx i[0], i[1];
cx i[1], i[0];
cx i[0], i[1];
x i;

// this method also works...
// cx i[1], i[0];
// cx i[0], i[1];
// x i[1];
// cx i[1], i[0];

measure i -> o;