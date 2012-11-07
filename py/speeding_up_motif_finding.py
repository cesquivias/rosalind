#!/usr/bin/env python

def failure_array(p):
    import pdb; pdb.set_trace()
    m = len(p)
    i = 0
    j = -1
    b = [j]
    while i < m:
        while j >= 0 and p[i] != p[j]:
            j = b[j]
        i += 1
        j += 1
        b.append(j)
    return b[1:]


if __name__ == '__main__':
    import sys

    strand = open(sys.argv[1]).read().strip()
    print ' '.join(str(i) for i in failure_array(strand))
