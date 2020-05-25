import qiskit
import Aer


### Joshua Larkin -- joslarki

### Need the majority circuit for the adder
majority_circuit = QuantumCircuit(3, 'maj')
majority_circuit.cx(2,0)
majority_circuit.cx(2,1)
majority_circuit.ccx(0,1,2)
majority = majority_circuit.to_instruction()

### And the unmajority circuit of course
unmajority_circuit = QuantumCircuit(3, 'uma')
unmajority_circuit.ccx(0,1,2)
unmajority_circuit.cx(2,0)
unmajority_circuit.cx(0,1)
unmajority = unmajority_circuit.to_instruction()


def run(c, p=False):
    emulator = Aer.get_backend('qasm_simulator')
    job = execute(c, emulator, shots=1)
    res = job.result().get_counts(c).popitem()[0][::-1]
    if p:
        print(res)
        print(c.qregs)
        print(c.draw())
    return res

def adder_circuit(n):
    if n <= 0:
        raise ValueError

    num_bits = (2 * n) + 2
    circuit = QuantumCircuit()
    c = QuantumRegister(1, 'c')
    a = QuantumRegister(n, 'a')
    b = QuantumRegister(n, 'b')
    s = QuantumRegister(1, 's')
    o = ClassicalRegister(num_bits, 'o')

   

    # cascade majority down as and bs 
    for i in range(n-1): 
        if i == 0:
            circuit.append(majority, [c[0], b[i], a[i]])
        else:
            circuit.append(majority, [a[i-1], b[i+1], a[i+1]])

    circuit.cx(a[n-1], s[0])

    for i in range(n-1,-1,-1):
        if i == 0:
            circuit.append(unmajority, [c[0], b[0], a[0]])
        else:
            circuit.append(unmajority, [a[i-1], b[i], a[i]])

    circuit.measure(c[0],o[0])
    for i in range(0,n):
        circuit.measure(a[i], o[i+1])
        circuit.measure(b[i], o[i+n+1])
    circuit.measure(s[0], o[num_bits-1])

    return circuit

def nat_to_bin(m):
    m_as_bin = []
    while m > 0:
        if m == 1:
            m_as_bin.append(1)
            break
        else:
            q, r = divmod(m, 2)
            m_as_bin.append(r)
            m = q
    return m_as_bin

def bin_to_nat(m):
    if m == []:
        return 0
    else:
        return m.pop(0) + (2 * bin_to_nat(m))


def plus(n,m):

    def pad(x,y):
        diff = len(x) - len(y)
        zeros = [0 for i in range(diff)]
        y += zeros
        return x,y

    n_bin = nat_to_bin(n)
    m_bin = nat_to_bin(m)
    n_size = len(n_bin)
    m_size = len(m_bin)
    size = n_size

    if n_size > m_size:
        n_bin, m_bin = pad(n_bin, m_bin)
    elif m_size > n_size:
        m_bin, n_bin = pad(m_bin, n_bin)
        size = m_size

    adder = adder_circuit(size)
    for i in range(size):
        if n_bin[i]:
            adder.x(1+i)
        if m_bin[i]:
            adder.x(size+i+1)

    run(adder,True)
