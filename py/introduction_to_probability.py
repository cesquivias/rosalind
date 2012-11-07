#!usr/bin/env python

from __future__ import division

def gc_probability(x):
    return 2 * ((x/2)**2 + ((1-x)/2)**2)

if __name__ == '__main__':
    import sys

    print ' '.join(str(gc_probability(float(n))) for n in open(sys.argv[1]).read().split())
