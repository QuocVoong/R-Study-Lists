#!/usr/bin/env python
#
# Created: 2013.12.11
# Usage: $ ./freqword.py <file>

import sys
from itertools import combinations, product
from collections import defaultdict


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


def main():
    with open(sys.argv[1], 'r') as fi:
        seq, k, d = fi.readline().split(' ')

    k = int(k)
    d = int(d)

    mutkmers = defaultdict(int)
    for kmer in gen_kmers(seq, k):
        mutkmers[kmer] += 1
        for i in xrange(1, d + 1):
            for mutkmer in mutate_kmer(kmer, i):
                mutkmers[mutkmer] += 1

    max_freq = 0
    best_kmers = []
    for i, j in mutkmers.iteritems():
        # print('%s: %s' % (i, j))
        if j > max_freq:
            best_kmers = [i]
            max_freq = j
        elif j == max_freq:
            best_kmers.append(i)

    for i in best_kmers:
        print(i)

    print(max_freq)


if __name__ == '__main__':
    main()
