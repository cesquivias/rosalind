#!/usr/bin/env python

def transcribe_rna(dna):
    return dna.replace('T', 'U')

if __name__ == '__main__':
    import sys

    f = sys.stdin if len(sys.argv) == 1 else open(sys.argv[1])
    print transcribe_rna(f.read())
        
