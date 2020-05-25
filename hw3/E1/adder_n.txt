##
## Exercise 1 - Part 2 - Pidgin
## Joshua Larkin -- joslarki
##

def majority(a, b, c):
  apply cx to  c, a
  apply cx to  c, b
  apply ccx to a, b, c
  

def unmaj_and_add(a, b, c):
  apply ccx to a, b, c
  apply cx  to c, a
  apply cx  to a, b
  
  return a, b, c


def adder(n):
  if n <= 0:
    raise ValueError

  # we need 2n + 2 registers

  adder_circuit = Circuit() # constructor for a blank circuit?
  as = [ new_register for i in range(n) ]
  bs = [ new_register for i in range(n) ]
  c_0 = new_register
  s_n = new_register

  add all of the above registers to adder_circuit

  # cascade majority down as and bs 
  for i = 0, i < n-1, i++: 
    if i == 0:
      apply majority to c_0, bs[i], as[i]
    else:
      apply majority to as[i-1], bs[i+1], as[i+1]
      
  apply cx to as[n-1], s_n

  # do unmajority-and-add
  for i = n-1, i >= 0, i--:
    if i = 0:
      apply unmaj_and_add to c_0, bs[0], as[0]
    else:
      apply unmaj_and_add to as[i-1], bs[i], as[i]

  return adder_circuit
