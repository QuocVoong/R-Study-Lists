#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        k = int(fi.readline())
        dna = []
        for line in fi:
            dna.append(line.strip())

    best_kmer = median_string(dna, k)
    print(best_kmer)


def median_string(dna, k):
    kmers = list(set(gen_kmers(dna, k)))
    best_kmer = kmers[0]
    min_d = distance(best_kmer, dna)
    for i in kmers[1:]:
        d = distance(i, dna)
        if d < min_d:
            best_kmer = i
            min_d = d

    return best_kmer


def gen_kmers(sequences, k):
    for i in sequences:
        for j in range(len(i) - k + 1):
            yield i[j: j + k]


def distance(kmer, dna):
    k = len(kmer)
    min_ds = []
    for i in dna:
        min_d = k
        for j in range(len(i) - len(kmer) + 1):
            d = score(kmer, i[j: j + k])
            if d < min_d:
                min_d = d
        min_ds.append(min_d)

    return sum(min_ds)


def score(seq_1, seq_2):
    s = len(seq_1)
    for i, j in zip(seq_1, seq_2):
        if i == j:
            s -= 1

    return s


if __name__ == '__main__':
    main()
