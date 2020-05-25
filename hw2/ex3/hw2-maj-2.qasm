OPENQASM 2.0;
include "qelib1.inc";

qreg in[4];
qreg zz[2];
creg out[4];
barrier in;

cx in[1], zz[0];
cx in[2], zz[1];
cx in[3], zz[1];

barrier in;

ccx in[1], in[2], zz[1];
ccx zz[0], zz[1], in[0];
ccx in[1], in[2], zz[1];

barrier in;

cx in[3], zz[1];
cx in[2], zz[1];
cx in[1], zz[0];


measure in -> out;