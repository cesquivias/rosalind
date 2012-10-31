#!/usr/bin/env python

def hamming_distance(s, t):
    return sum(cs != ct for cs, ct in zip(s, t))

if __name__ == '__main__':
    import sys

    s, t = open(sys.argv[1]).read().split('\n')
    print hamming_distance(s, t)
