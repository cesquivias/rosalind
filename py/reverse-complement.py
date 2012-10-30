#!/usr/bin/env python

def reverse_complement(strand):
    comp = {
        'A': 'T',
        'C': 'G',
        'G': 'C',
        'T': 'A',
        }
    return ''.join(reversed([comp[c] for c in strand.strip()]))

if __name__ == '__main__':
    import sys

    print reverse_complement(open(sys.argv[1]).read())
