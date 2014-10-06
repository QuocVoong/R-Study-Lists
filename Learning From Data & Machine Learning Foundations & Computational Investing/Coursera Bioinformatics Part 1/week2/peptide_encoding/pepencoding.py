#!/usr/bin/env python

import sys


def translation(text):
    codon_table = {
        'TTT': 'F',
        'CTT': 'L',
        'ATT': 'I',
        'GTT': 'V',
        'TTC': 'F',
        'CTC': 'L',
        'ATC': 'I',
        'GTC': 'V',
        'TTA': 'L',
        'CTA': 'L',
        'ATA': 'I',
        'GTA': 'V',
        'TTG': 'L',
        'CTG': 'L',
        'ATG': 'M',
        'GTG': 'V',
        'TCT': 'S',
        'CCT': 'P',
        'ACT': 'T',
        'GCT': 'A',
        'TCC': 'S',
        'CCC': 'P',
        'ACC': 'T',
        'GCC': 'A',
        'TCA': 'S',
        'CCA': 'P',
        'ACA': 'T',
        'GCA': 'A',
        'TCG': 'S',
        'CCG': 'P',
        'ACG': 'T',
        'GCG': 'A',
        'TAT': 'Y',
        'CAT': 'H',
        'AAT': 'N',
        'GAT': 'D',
        'TAC': 'Y',
        'CAC': 'H',
        'AAC': 'N',
        'GAC': 'D',
        'TAA': '',
        'CAA': 'Q',
        'AAA': 'K',
        'GAA': 'E',
        'TAG': '',
        'CAG': 'Q',
        'AAG': 'K',
        'GAG': 'E',
        'TGT': 'C',
        'CGT': 'R',
        'AGT': 'S',
        'GGT': 'G',
        'TGC': 'C',
        'CGC': 'R',
        'AGC': 'S',
        'GGC': 'G',
        'TGA': '',
        'CGA': 'R',
        'AGA': 'R',
        'GGA': 'G',
        'TGG': 'W',
        'CGG': 'R',
        'AGG': 'R',
        'GGG': 'G',
    }

    aa = []
    for i in range(0, len(text), 3):
        if codon_table.get(text[i:i + 3]):
            aa.append(codon_table.get(text[i:i + 3]))

    return ''.join(aa)


def revcomp(seq):
    table = {
        'A': 'T',
        'T': 'A',
        'C': 'G',
        'G': 'C',
    }
    rc_seq = []
    for i in seq[::-1]:
        rc_seq.append(table.get(i))

    return ''.join(rc_seq)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        peptide = fi.readline().strip()

    subseqlen = 3 * len(peptide)
    for i in range(len(seq) - subseqlen + 1):
        if translation(seq[i: i + subseqlen]) == peptide:
            print(seq[i: i + subseqlen])
        if translation(revcomp(seq[i: i + subseqlen])) == peptide:
            print(seq[i: i + subseqlen])


if __name__ == '__main__':
    main()
