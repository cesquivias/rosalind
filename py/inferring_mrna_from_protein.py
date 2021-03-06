#!/usr/bin/env python

from collections import defaultdict
from operator import mul

codon = defaultdict(list)
codon['F'].append('UUU')
codon['L'].append('CUU')
codon['I'].append('AUU')
codon['V'].append('GUU')
codon['F'].append('UUC')
codon['L'].append('CUC')
codon['I'].append('AUC')
codon['V'].append('GUC')
codon['L'].append('UUA')
codon['L'].append('CUA')
codon['I'].append('AUA')
codon['V'].append('GUA')
codon['L'].append('UUG')
codon['L'].append('CUG')
codon['M'].append('AUG')
codon['V'].append('GUG')
codon['S'].append('UCU')
codon['P'].append('CCU')
codon['T'].append('ACU')
codon['A'].append('GCU')
codon['S'].append('UCC')
codon['P'].append('CCC')
codon['T'].append('ACC')
codon['A'].append('GCC')
codon['S'].append('UCA')
codon['P'].append('CCA')
codon['T'].append('ACA')
codon['A'].append('GCA')
codon['S'].append('UCG')
codon['P'].append('CCG')
codon['T'].append('ACG')
codon['A'].append('GCG')
codon['Y'].append('UAU')
codon['H'].append('CAU')
codon['N'].append('AAU')
codon['D'].append('GAU')
codon['Y'].append('UAC')
codon['H'].append('CAC')
codon['N'].append('AAC')
codon['D'].append('GAC')
codon['Stop'].append('UAA')
codon['Q'].append('CAA')
codon['K'].append('AAA')
codon['E'].append('GAA')
codon['Stop'].append('UAG')
codon['Q'].append('CAG')
codon['K'].append('AAG')
codon['E'].append('GAG')
codon['C'].append('UGU')
codon['R'].append('CGU')
codon['S'].append('AGU')
codon['G'].append('GGU')
codon['C'].append('UGC')
codon['R'].append('CGC')
codon['S'].append('AGC')
codon['G'].append('GGC')
codon['Stop'].append('UGA')
codon['R'].append('CGA')
codon['R'].append('AGA')
codon['G'].append('GGA')
codon['W'].append('UGG')
codon['R'].append('CGG')
codon['R'].append('AGG')
codon['G'].append('GGG') 

def protein_possiblities(protein):
    return reduce(mul, (len(codon[aa]) for aa in protein), 1) * len(codon['Stop'])

if __name__ == '__main__':
    import sys

    protein = open(sys.argv[1]).read().strip()
    print (protein_possiblities(protein) % 1000000)
