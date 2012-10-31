#!/usr/bin/env python

from __future__ import division

def gc_percentage(strand):
    return sum(c in ['C', 'G'] for c in strand) / len(strand) * 100 \
        if strand else 0

def gc_stats(lines):
    gc_content = {}
    name = None
    for line in lines:
        if line.startswith('>'):
            if name:
                gc_content[name] = gc_percentage(strand)
            name = line[1:].strip()
            strand = ''
        else:
            strand += line.strip()
    else:
        gc_content[name] = gc_percentage(strand)
    return gc_content


if __name__ == '__main__':
    import sys

    gc_content = gc_stats(open(sys.argv[1]).readlines())
    max_strand = max(gc_content, key=gc_content.get)
    print max_strand
    print "%2.6f%%" % gc_content[max_strand]
