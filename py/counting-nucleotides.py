#!/usr/bin/env python

from collections import Counter

def total_nucleotides(nucleotides):
    counter = Counter()
    for c in nucleotides:
        counter[c] += 1
    return (counter['A'], counter['C'], counter['G'], counter['T'])

if __name__ == '__main__':
    import sys
    print ' '.join(str(i) for i in total_nucleotides(open(sys.argv[1]).read()))
