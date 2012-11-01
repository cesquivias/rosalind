#!/usr/bin/env python

from __future__ import division

from fasta import read_fasta

def gc_percentage(strand):
    return sum(c in ['C', 'G'] for c in strand) / len(strand) * 100 \
        if strand else 0


if __name__ == '__main__':
    import sys

    strands = read_fasta(open(sys.argv[1]))
    gc_content = dict((name, gc_percentage(strands[name])) for name in strands)
    max_strand = max(gc_content, key=gc_content.get)
    print max_strand
    print "%2.6f%%" % gc_content[max_strand]
