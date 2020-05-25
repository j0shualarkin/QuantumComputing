OPENQASM 2.0;
include "qelib1.inc";

qreg alpha[3]; // only care when alpha[0] = 0 
qreg in[6]; // the last one is the answer bit
creg out[6];

barrier alpha, in;

ccx in[3], in[4], alpha[0];
cx in[3], in[4];
cx in[4], alpha[0];
cx in[3], in[4];

barrier in, alpha;

//    i[0] = in[0], 
//    i[1] = in[1], 
//    i[2] = alpha[0],
//    i[3] = in[5];
//    a[0] = alpha[1];

// cccx in[0], in[1], alpha[0], in[5];
// -->
ccx in[0], in[1], alpha[1];
ccx alpha[0], alpha[1], in[5];
ccx in[0], in[1], alpha[1];


// --------------
//    i[0] = in[1], 
//    i[1] = in[2], 
//    i[2] = alpha[0],
//    i[3] = in[5];
//    a[0] = alpha[1];

// cccx in[1], in[2], alpha[0], in[5];
// -->
ccx in[1], in[2], alpha[1];
ccx alpha[0], alpha[1], in[5];
ccx in[1], in[2], alpha[1];


// --------------

//    i[0] = in[0], 
//    i[1] = in[2], 
//    i[2] = alpha[0],
//    i[3] = in[5];
//    a[0] = alpha[1];

// cccx in[0], in[2], alpha[0], in[5];
// -->
ccx in[0], in[2], alpha[1];
ccx alpha[0], alpha[1], in[5];
ccx in[0], in[2], alpha[1];

// --------------

//    i[0] = in[0], 
//    i[1] = in[1], 
//    i[2] = in[2]
//    i[3] = in[5];
//    a[0] = alpha[1];

// cccx in[0], in[1], in[2], in[5];
// -->
ccx in[0], in[1], alpha[1];
ccx in[2], alpha[1], in[5];
ccx in[0], in[1], alpha[1];


// --------------

//    i[0] = in[0], 
//    i[1] = in[3], 
//    i[2] = in[4]
//    i[3] = in[5];
//    a[0] = alpha[1];

// cccx in[0], in[3], in[4], in[5];
// -->
ccx in[0], in[3], alpha[1];
ccx in[4], alpha[1], in[5];
ccx in[0], in[3], alpha[1];

// --------------

//    i[0] = in[1] 
//    i[1] = in[3] 
//    i[2] = in[4]
//    i[3] = in[5]
//    a[0] = alpha[1]

// cccx in[1], in[3], in[4], in[5];
// -->
ccx in[1], in[3], alpha[1];
ccx in[4], alpha[1], in[5];
ccx in[1], in[3], alpha[1];


// --------------

//    i[0] = in[2] 
//    i[1] = in[3]
//    i[2] = in[4]
//    i[3] = in[5]
//    a[0] = alpha[1];

// cccx in[2], in[3], in[4], in[5];
// -->
ccx in[2], in[3], alpha[1];
ccx in[4], alpha[1], in[5];
ccx in[2], in[3], alpha[1];

// --------------

// gs[0] = in[0]
// gs[1] = in[1]
// gs[2] = in[2]
// gs[3] = in[3]
// gs[4] = in[5]
// anc[0] = alpha[1]
// anc[1] = alpha[2]


// ccccx in[0], in[1], in[2], in[3], in[5]; // catch the 11101 case
// -->
ccx in[0], in[1], alpha[1];
ccx in[2], in[3], alpha[2];
ccx alpha[1], alpha[2], in[5];
ccx in[2], in[3], alpha[2];
ccx in[0], in[1], alpha[1];


// --------------

// ccccx in[0], in[1], in[3], in[4], in[5]; // catch the 11110 case
// -->

// gs[0] = in[0]
// gs[1] = in[1]
// gs[2] = in[3]
// gs[3] = in[4]
// gs[4] = in[5]

ccx in[0], in[1], alpha[1];
ccx in[3], in[4], alpha[2];
ccx alpha[1], alpha[2], in[5];
ccx in[3], in[4], alpha[2];
ccx in[0], in[1], alpha[1];



// --------------

barrier in, alpha;

cx  in[3], in[4];
cx  in[4], alpha[0];
cx  in[3], in[4];
ccx in[3], in[4], alpha[0];


barrier alpha, in;

measure in -> out;