#!/usr/bin/env python

def transcribe_rna(dna):
    return dna.replace('T', 'U')

if __name__ == '__main__':
    import sys

    print transcribe_rna(open(sys.argv[1]).read())
