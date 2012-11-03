#!/usr/bin/env python

from __future__ import division

def prob_match(x, m):
    a = (1-x)/2
    c = x/2
    g = x/2
    t = a

    return (a**2 + c**2 + g**2 + t**2) ** m

def expected_value(probability, sub_len, total_len):
    return prob_match(probability, sub_len) * (total_len - sub_len + 1)

if __name__ == '__main__':
    import sys

    lines = open(sys.argv[1]).readlines()
    m, n = [int(i) for i in lines[0].strip().split()]
    probabilities = [float(i) for i in lines[1].strip().split()]

    print ' '.join(str(expected_value(prob, m, n)) for prob in probabilities)
