OPENQASM 2.0;
include "qelib1.inc";

// This works when inp[2] = 1 !

qreg inp[3];
creg out[3];

barrier inp;

ccx inp[0], inp[1], inp[2]; 

ccx inp[1], inp[2], inp[0];

barrier inp;

measure inp -> out;