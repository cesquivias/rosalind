#!/usr/bin/env python

from collections import OrderedDict
from itertools import chain

from fasta import read_fasta

def directed_edges(node, nodes):
    edges = []
    name, strand = node
    for n, s in nodes:
        if strand[-3:] == s[:3]:
            edges.append(n)
    return edges

def all_adjacencies(nodes):
    adjacencies = OrderedDict()
    for name, strand in nodes.iteritems():
        adjacencies[name] = directed_edges((name, strand),
                                           ((n, s) for n, s in nodes.iteritems()
                                            if n != name))
    return adjacencies


if __name__ == '__main__':
    import sys
    
    nodes = read_fasta(open(sys.argv[1]))
    adjacencies = all_adjacencies(nodes)
    for tail in (name for name in adjacencies if adjacencies[name]):
        print '\n'.join("%s %s" % (tail, head) for head in adjacencies[tail])
