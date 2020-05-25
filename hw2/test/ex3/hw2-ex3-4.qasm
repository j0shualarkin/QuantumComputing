OPENQASM 2.0;
include "qelib1.inc";

// Design a 3-bit reversible circuit 
// which swaps 000 and 011 and leaves other inputs fixed 

qreg i[3];
creg out[3];

barrier i;

ccx i[0], i[1], i[2];
ccx i[0], i[2], i[1];
ccx i[0], i[1], i[2];

cx i[0], i[2];
cx i[0], i[1];
cx i[1], i[2];
cx i[2], i[1];
cx i[1], i[2];

x i[1];
x i[2];

barrier i;

measure i -> out;