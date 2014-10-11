#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        k, t = [int(i) for i in fi.readline().split(' ')]
        dna = []
        for line in fi:
            dna.append(line.strip())

    best_motifs = greedy_motif_search(dna, k, t)
    for i in best_motifs:
        print(i)


def greedy_motif_search(dna, k, t):
    best_motifs = []
    for i in dna:
        best_motifs.append(i[0: k])
    for i in gen_kmers(dna[0], k):
        motif_1 = i
        motifs = [motif_1]
        for j in range(1, t):
            profile = form_profile(motifs[0: j])
            motif_i = profile_most_prob_kmer(dna[j], k, profile)
            if not motif_i:
                motif_i = dna[j][0:k]
            motifs.append(motif_i)
        if score(motifs) < score(best_motifs):
            best_motifs = motifs

    return best_motifs


def gen_kmers(sequence, k):
    for i in range(len(sequence) - k + 1):
        yield sequence[i: i + k]


def profile_most_prob_kmer(sequence, k, matrix):
    best_kmer = None
    best_prob = 0
    for i in gen_kmers(sequence, k):
        prob = calc_prob(i, matrix)
        if prob > best_prob:
            best_kmer = i
            best_prob = prob

    return best_kmer


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


def form_profile(motifs):
    matrix = []
    for i in zip(*motifs):
        count = {'A': 0.0, 'C': 0.0, 'G': 0.0, 'T': 0.0}
        for j in i:
            count[j] += 1
        for c in count:
            count[c] = count.get(c) / len(i)
        matrix.append([count.get('A'), count.get('C'), count.get('G'), count.get('T')])

    return matrix


def score(motifs):
    s = 1
    for i in zip(*motifs):
        nt = {}
        for j in i:
            if j in nt:
                nt[j] += 1
            else:
                nt.update({j: 0})
        s *= max(nt.values())

    return 1 - s


if __name__ == '__main__':
    main()
