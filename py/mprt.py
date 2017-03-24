#!/usr/bin/env python

from urllib import urlopen
import regex as re

import fasta

n_glycosylation_motif = re.compile(r'N[^P][ST][^P]')

def motif_locations(fasta_file):
    data = fasta.read_fasta(fasta_file).popitem()[1]
    return [m.start(0) + 1 for m in n_glycosylation_motif.finditer(data, overlapped=True)]

def download_uniprot(uniprot_id):
    url = 'http://www.uniprot.org/uniprot/%s.fasta' % uniprot_id
    return urlopen(url)


if __name__ == '__main__':
    import sys

    f = sys.stdin if len(sys.argv) == 1 else open(sys.argv[1])
    for uniprot_id in (l.strip() for l in f.readlines()):
        locations = motif_locations(download_uniprot(uniprot_id))
        if locations:
            print uniprot_id
            print ' '.join(str(i) for i in locations)
