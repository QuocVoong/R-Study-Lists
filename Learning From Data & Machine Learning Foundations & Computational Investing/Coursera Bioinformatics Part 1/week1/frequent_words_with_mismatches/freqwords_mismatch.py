#!/usr/bin/env python

import sys


def genkmers(k):
    if k == 1:
        return ['A', 'T', 'C', 'G']
    else:
        sequence = []
        for i in genkmers(k - 1):
            for j in ['A', 'T', 'C', 'G']:
                sequence.append(''.join([j, i]))
        return sequence


def main():
    with open(sys.argv[1], 'r') as fi:
        seq, k, d = fi.readline().strip().split(' ')

    k = int(k)
    d = int(d)

    kmer = {}
    for i in genkmers(k):
        kmer.update({i: 0})

    for i in range(len(seq) - k + 1):
        for j in kmer:
            mismatch = 0
            has_match = True
            for a, b in zip(j, seq[i: i + k]):
                if a != b:
                    mismatch += 1
                    if mismatch > d:
                        has_match = False
                        break
            if has_match:
                kmer[j] += 1
            if has_match and j == 'GCACACAGAC':
                print(seq[i: i + k])

    max_freq = 0
    max_kmers = []
    for i, j in kmer.iteritems():
        if j > max_freq:
            max_freq = j
            max_kmers = [i]
        elif j == max_freq:
            max_kmers.append(i)

    print(' '.join(max_kmers))


if __name__ == '__main__':
    main()
