from __future__ import division

from operator import mul
from fractions import Fraction

def nCk(n,k): 
  return int(reduce(mul, (Fraction(n-i, i+1) for i in range(k)), 1))


def AaBa_prob(k, N):
    kids = 2**k
    total = 0
    for i in xrange(kids - N + 1):
        c = nCk(kids, i)
        x = 0.25 ** (kids - i)
        y = 0.75 ** i
        total += c * x * y

    return total
