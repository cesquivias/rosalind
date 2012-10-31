#!/usr/bin/env python

from itertools import permutations

if __name__ == '__main__':
    import sys

    num = int(open(sys.argv[1]).read())
    perms = list(permutations(range(1,num+1)))
    print len(perms)
    for p in perms:
        print ' '.join(map(str, p))
