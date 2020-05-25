OPENQASM 2.0;
include "qelib1.inc";

// computes ccccx (4 controlled not) (5 bit toffoli)

qreg anc[2];
qreg gs[5];
creg out[5];
barrier in;

ccx gs[0], gs[1], anc[0];
ccx gs[2], gs[3], anc[1];
ccx anc[0], anc[1], gs[4];
ccx gs[2], gs[3], anc[1];
ccx gs[0], gs[1], anc[0];

measure gs -> out;