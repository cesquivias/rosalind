#!/usr/bin/env python

def longest_motif(strands):
    strands = strands[:]
    shortest_strand = min(strands, key=len)
    strands.remove(shortest_strand)

    longest = ''
    for start in xrange(len(shortest_strand)):
        for end in xrange(len(shortest_strand), start+1, -1):
            candidate = shortest_strand[start:end]
            if all(candidate in strand for strand in strands) \
                    and len(candidate) > len(longest):
                longest = candidate
    return longest


if __name__ == '__main__':
    import sys

    strands = [l.strip() for l in open(sys.argv[1]).readlines()]
    print longest_motif(strands)
