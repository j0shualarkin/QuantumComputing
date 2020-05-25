OPENQASM 2.0;
include "qelib1.inc";

qreg a[3];
qreg i[6];
creg o[6];

barrier i,a;

ccx i[0], i[1], a[0];
ccx i[2], i[3], a[1];

ccx a[0], a[1], a[2];

ccx a[2], i[4], i[5];

ccx a[0], a[1], a[2];

ccx i[2], i[3], a[1];
ccx i[0], i[1], a[0];

barrier i,a;

measure i -> o;