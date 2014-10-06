#!/usr/bin/env python

import sys
from itertools import combinations, product, izip


def gen_kmers(seq, k):
    for i in xrange(len(seq) - k + 1):
        yield seq[i: i + k]


def mutate_kmer(kmer, d, chars='ATCG'):
    for i in combinations(xrange(len(kmer)), d):
        for j in product(chars, repeat=d):
            mutkmer = [x for x in kmer]
            cont = 1
            for a, b in zip(i, j):
                if mutkmer[a] == b:
                    cont = 0
                    break
                mutkmer[a] = b
            if cont:
                yield ''.join(mutkmer)


def appear_in_dna(kmer, seq, d):
    skmers = set()
    for i in xrange(len(seq) - len(kmer) + 1):
        skmer = seq[i: i + len(kmer)]
        if skmer not in skmers:
            da = 0
            for m, n in izip(kmer, skmer):
                if m != n:
                    da += 1
            if da <= d:
                return True
        skmers.add(skmer)

    return False


def main():
    with open(sys.argv[1], 'r') as fi:
        k, d = [int(x) for x in fi.readline().split(' ')]
        dna = []
        for line in fi:
            dna.append(line.rstrip('\n'))

    motifs = set()
    for kmer in gen_kmers(dna[0], k):
        if kmer not in motifs:
            appear_all = True
            for s in dna[1:]:
                if not appear_in_dna(kmer, s, d):
                    appear_all = False
                    break
            if appear_all:
                motifs.add(kmer)
        for i in xrange(1, d + 1):
            for mutkmer in mutate_kmer(kmer, i):
                if mutkmer not in motifs:
                    appear_all = True
                    for s in dna[1:]:
                        if not appear_in_dna(mutkmer, s, d):
                            appear_all = False
                            break
                    if appear_all:
                        motifs.add(mutkmer)

    for i in motifs:
        print(i)


if __name__ == '__main__':
    main()
