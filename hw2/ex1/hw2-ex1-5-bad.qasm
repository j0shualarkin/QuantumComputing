OPENQASM 2.0;
include "qelib1.inc";

qreg in[6];
qreg a[5];
creg out[6];
barrier in;

cx in[0], a[0];
cx in[1], a[1];
cx in[2], a[2];
cx in[3], a[3];
cx in[4], a[4];



cx in[4], a[4];
cx in[3], a[3];
cx in[2], a[2];
cx in[1], a[1];
cx in[0], a[0];



measure in -> out;