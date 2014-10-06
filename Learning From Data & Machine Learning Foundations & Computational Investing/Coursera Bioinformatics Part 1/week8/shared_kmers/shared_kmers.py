#!/usr/bin/env python

import sys


def shared_kmers(k, seq_1, seq_2):
    kmers_seq_1 = {}
    for i in range(len(seq_1) - k + 1):
        kmer = seq_1[i: i + k]
        if kmer in kmers_seq_1:
            kmers_seq_1.get(kmer).append(i)
        else:
            kmers_seq_1.update({kmer: [i]})

    for i in range(len(seq_2) - k + 1):
        kmer = seq_2[i: i + k]
        if kmer in kmers_seq_1:
            for j in kmers_seq_1.get(kmer):
                yield (j, i)
        else:
            rc_kmer = revcomp(kmer)
            if rc_kmer in kmers_seq_1:
                for j in kmers_seq_1.get(rc_kmer):
                    yield (j, i)


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
        k = int(fi.readline())
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()

    for i, j in shared_kmers(k, seq_1, seq_2):
        print('({0}, {1})'.format(i, j))


if __name__ == '__main__':
    main()
