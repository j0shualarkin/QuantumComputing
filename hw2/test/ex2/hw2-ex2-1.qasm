OPENQASM 2.0;
include "qelib1.inc";

qreg a[1];
qreg i[4];
creg o[4];

barrier i;

ccx i[0], i[1], a[0];
ccx i[2], a[0], i[3];
ccx i[0], i[1], a[0];

measure i -> o;