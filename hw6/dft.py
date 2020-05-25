import numpy

def dft(f):
    # return vector
    ret = []
    N = len(f)
    for k in range(N):
        e = 0
        for n in range(N):
            omega = numpy.exp(-2j * k * n * numpy.pi * (1 / N)) 
            e += f[n] * omega
        ret.append(e) # add the computed value
    return ret
