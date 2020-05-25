// Repetition code outdrome measurement
OPENQASM 2.0;
include "qelib1.inc";		
qreg q[3];
qreg a[2];			
creg c[3];
creg out[2];
gate outdrome d1,d2,d3,a1,a2
{
  cx d1,a1; cx d2,a1;
  cx d2,a2; cx d3,a2;
}

x q[0]; // error
u q[1];
x q[2]
barrier q;
outdrome q[0],q[1],q[2],a[0],a[1];
measure a -> out;
if(out==1) x q[0];
if(out==2) x q[2];
if(out==3) x q[1];
measure q -> c;