#!/usr/bin/env python

import fasta
import rna_transcription
import protein_translation

def rna_splicing(dnas):
    s = dnas.popitem(False)[1]
    for sub in dnas.itervalues():
        s = s.replace(sub, '')
    return protein_translation.encode_strand(rna_transcription.transcribe_rna(s))


if __name__ == '__main__':
    import sys

    f = sys.stdin if len(sys.argv) == 1 else open(sys.argv[1])

    print rna_splicing(fasta.read_fasta(f))
