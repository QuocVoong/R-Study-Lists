#!/usr/bin/env python

import sys
import random


def main():
    with open(sys.argv[1], 'r') as fi:
        k, t, N = [int(i) for i in fi.readline().split(' ')]
        dna = []
        for line in fi:
            dna.append(line.strip())

    best_motifs = gibbs_sampler(dna, k, t, N)
    for i in range(20):
        motifs = gibbs_sampler(dna, k, t, N)
        if score(motifs) < score(best_motifs):
            best_motifs = motifs
    for i in best_motifs:
        print(i)


def gibbs_sampler(dna, k, t, N):
    motifs = gen_random_motifs(dna, k)
    best_motifs = motifs
    for i in range(N):
        i = random.randint(0, t - 1)
        motifs.pop(i)
        profile = form_profile(motifs)
        motifs.insert(i, gen_profile_random_kmer(dna[i], profile))
        if score(motifs) < score(best_motifs):
            best_motifs = motifs

    return best_motifs


def gen_random_motifs(dna, k):
    motifs = []
    for i in dna:
        r = random.randint(0, k - 1)
        motifs.append(i[r: r + k])

    return motifs


def form_profile(motifs):
    matrix = []
    for i in zip(*motifs):
        count = {'A': 1.0, 'C': 1.0, 'G': 1.0, 'T': 1.0}
        for j in i:
            count[j] += 1
        for c in count:
            count[c] = count.get(c) / len(i)
        matrix.append([count.get('A'), count.get('C'), count.get('G'), count.get('T')])

    return matrix


def gen_profile_random_kmer(sequence, profile):
    k = len(profile)
    return profile_most_prob_kmer(sequence, k, profile)


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
