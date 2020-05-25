OPENQASM 2.0;
include "qelib1.inc";

// does what it should,
// but doesn't use ccx as request =/

qreg anc[1];
qreg inp[3];
// qreg anc[3];
creg out[3];

barrier inp;

x inp[2];
ccx inp[0], inp[2], anc[0];
ccx inp[1], anc[0], inp[2];
// cx inp[0], inp[2];

barrier inp;

// cx inp[1], inp[2];

barrier inp;

// ccx inp[0], inp[1], inp[2]; 

// ccx inp[0], inp[1], anc[0];

barrier inp;

measure inp -> out;