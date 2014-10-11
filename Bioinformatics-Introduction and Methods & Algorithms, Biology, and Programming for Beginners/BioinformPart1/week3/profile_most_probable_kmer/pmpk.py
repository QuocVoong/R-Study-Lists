#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        sequence = fi.readline().strip()
        k = int(fi.readline())
        fi.readline()
        matrix = []
        for line in fi:
            matrix.append([float(i) for i in line.strip().split(' ')])

    best_kmer = profile_most_prob_kmer(sequence, k, matrix)
    print(best_kmer)


def profile_most_prob_kmer(sequence, k, matrix):
    best_kmer = None
    best_prob = 0
    for i in gen_kmers(sequence, k):
        prob = calc_prob(i, matrix)
        if prob > best_prob:
            best_kmer = i
            best_prob = prob

    return best_kmer


def gen_kmers(sequence, k):
    for i in range(len(sequence) - k + 1):
        yield sequence[i: i + k]


def calc_prob(kmer, matrix):
    nt = {
        'A': 0,
        'C': 1,
        'G': 2,
        'T': 3,
    }

    prob = 1
    for i, j in enumerate(kmer):
        prob *= matrix[i][nt.get(j)]

    return prob


if __name__ == '__main__':
    main()
