OPENQASM 2.0;
include "qelib1.inc";

qreg i[2];
creg o[2];

barrier i;

x i[1];
cx i[0], i[1];

measure i -> o;