#!/usr/bin/env python

import sys
from itertools import combinations


def gen_mutation(k):
    if k == 1:
        for i in {'A', 'T', 'C', 'G'}:
            yield i
    else:
        for i in {'A', 'T', 'C', 'G'}:
            for j in gen_mutation(k - 1):
                yield i + j


def main():
    with open(sys.argv[1], 'r') as fi:
        k, d = [int(i) for i in fi.readline().split(' ')]

        dna = []
        for line in fi:
            dna.append(line.strip())

        motifs = set()
        for sequence in dna:
            for i in range(len(sequence) - k):
                kmer = sequence[i: i + k]
                motifs.add(kmer)
                new_kmer = list(kmer)
                for combination in combinations(range(len(kmer)), d):
                    for mutations in gen_mutation(d):
                        for p, m in zip(combination, mutations):
                            new_kmer[p] = m
                        motifs.add(''.join(new_kmer))
                        new_kmer = list(kmer)

        new_motifs = set()
        for kmer in motifs:
            count = 0
            for sequence in dna:
                match = False
                for i in range(len(sequence) - k + 1):
                    substring = sequence[i: i + k]
                    if kmer == substring:
                        match = True
                        break
                    new_kmer = list(kmer)
                    for combination in combinations(range(len(new_kmer)), d):
                        for mutations in gen_mutation(d):
                            for p, m in zip(combination, mutations):
                                new_kmer[p] = m
                            if ''.join(new_kmer) == substring:
                                match = True
                            new_kmer = list(kmer)

                if match:
                    count += 1

            if count == len(dna):
                new_motifs.add(''.join(kmer))

        print(' '.join(new_motifs))


if __name__ == '__main__':
    main()
