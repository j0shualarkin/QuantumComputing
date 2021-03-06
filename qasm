#!/usr/bin/env python3

import argparse
from copy import deepcopy
from itertools import dropwhile, product
from qiskit import QuantumCircuit, execute
from qiskit.extensions.standard.barrier import Barrier


from qiskit import Aer
backend = Aer.get_backend("qasm_simulator")

def setup_circuit_inputs(qc, bits):
    """Assumes that the number of quantum registers in qc is equal to the
    number of bits. Assumes that bits is a string of integers in {0,1}.

    Assumes that qc follows this sequence:
      1. maybe input setup
      2. barrier
      3. circuit definition
      4. maybe barrier
      5. maybe measurements

    Strips the first barrier and everything before. Strips the final
    measurements and the barrier before. Sets up the input qubits
    according to bits. Measures every qubit.

    """
    qc = qc.copy()
    
    # strip first barrier and everything before
    qc.data = list(dropwhile(lambda o: not isinstance(o[0], Barrier), qc._data))
    qc.data = qc._data[1:]
    
    # strip any classical registers and measurements
    qc.remove_final_measurements()
    
    # build circuit containing just the input setup
    inputs = QuantumCircuit()
    inputs.qregs = deepcopy(qc.qregs)

    qubits = [qb for qr in inputs.qregs for qb in qr]
    
    for i, b in enumerate(bits):
        if (b == '1'):
            inputs.x(qubits[i])
            
    inputs.barrier()

    # new circuit
    qc_with_inputs = inputs + qc
    qc_with_inputs.measure_all()
    qc_with_inputs.cregs[0].name = 'out'

    return qc_with_inputs


def classical_result(qc):
    """Note: get_counts returns keys that list bits in reverse order of
    the classical registers.

    """
    job = execute(qc, backend=backend, shots=1)
    result = job.result()
    return result.get_counts(qc).popitem()[0][::-1]


def truth_table_row(input, output):
    return ("| "  + " ".join(list(input)) +
            " | " + " ".join(list(output)) + " |")


def truth_table_horizontal(n_inputs, n_outputs):
    return ("+" + "-" * (n_inputs * 2 + 1) +
            "+" + "-" * (n_outputs * 2 + 1) + "+")

    
if __name__ == "__main__":
  parser = argparse.ArgumentParser(
    description='Run a qasm program, optionally on a '
                'given classical input or on all classical inputs. '
                'Output bits listed in order of the registers.')
  parser.add_argument('filename', type=str,
                      help='name of qasm file')
  parser.add_argument('-d', '--draw', action='store_const', const=True,
                      help='draws the circuit')
  parser.add_argument('-b', '--bits', type=str,
                      help='input bits (integers 0 or 1) '
                           'as string in order of registers')
  parser.add_argument('-t', '--truth-table', action='store_const', const=True,
                      help='computes and displays truth table of the circuit')
  
  args = parser.parse_args()

  qc = QuantumCircuit.from_qasm_file(args.filename)

  if args.bits and args.truth_table:
      raise Exception('Options -b and -t are incompatible')

  if args.bits:
      if not (len(args.bits) == qc.n_qubits):
          raise Exception('{} bits provided but circuit takes {} input bits'
                          .format(len(args.bits), qc.n_qubits))
  
      qc_with_inputs = setup_circuit_inputs(qc, args.bits)

      if args.draw:
          print(qc_with_inputs.draw(output="text"))

      print(classical_result(qc_with_inputs))

  elif args.truth_table:
      if args.draw:
          qc_with_inputs = setup_circuit_inputs(qc, [0] * qc.n_qubits)
          print(qc_with_inputs.draw(output="text"))

      print()
      print(truth_table_horizontal(qc.n_qubits, qc.n_qubits))
      for input in product([0, 1], repeat=qc.n_qubits):
          input = "".join(map(str, input))
          
          qc_with_inputs = setup_circuit_inputs(qc, input)

          output = classical_result(qc_with_inputs)
                    
          print(truth_table_row(input, output))
          
      print(truth_table_horizontal(qc.n_qubits, qc.n_qubits))
      print()
      
  else:
      if args.draw:
          print(qc.draw(output="text"))

      print(classical_result(qc))
