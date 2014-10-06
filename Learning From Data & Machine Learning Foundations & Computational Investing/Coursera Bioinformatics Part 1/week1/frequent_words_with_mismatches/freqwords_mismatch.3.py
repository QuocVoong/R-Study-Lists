#!/usr/bin/env python
# TODO

import re
import sys
from itertools import combinations
from collections import defaultdict


def masked_kmers_with_hits(seq, k, d):
    kmers = defaultdict(int)
    masked_kmers = defaultdict(set)
    for i in xrange(len(seq) - k + 1):
        kmer = seq[i: i + k]
        kmers[kmer] += 1
        for i in xrange(1, d + 1):
            for c in (x for x in combinations(xrange(k), i)):
                kmer_list = [x for x in kmer]
                for x in c:
                    kmer_list[x] = 'n'
                mkmer = ''.join(kmer_list)
                kmers[mkmer] += 1
                masked_kmers[kmer].add(mkmer)

    return kmers, masked_kmers


# def masked_kmers_with_hits(seq, k, d):
#     kmers = {}
#     masked_kmers = {}
#     for i in xrange(1, d + 1):
#         index_combinations = [x for x in combinations(xrange(k), i)]

#     for i in xrange(len(seq) - k + 1):
#         kmer = seq[i: i + k]
#         if kmer in kmers:
#             kmers[kmer].append((kmer, i))
#         else:
#             kmers.update({kmer: [(kmer, i)]})
#         for c in index_combinations:
#             mkmer = list(kmer)
#             for x in c:
#                 mkmer[x] = 'n'
#             mkmer = ''.join(mkmer)
#             if mkmer in kmers:
#                 kmers[mkmer].append((kmer, i))
#             else:
#                 kmers.update({mkmer: [(kmer, i)]})
#             if kmer in masked_kmers:
#                 masked_kmers[kmer].add(mkmer)
#             else:
#                 masked_kmers.update({kmer: {mkmer}})

#     return kmers, masked_kmers


def find_match_sequences(patterns, seq):
    frequency = {}
    for i in patterns:
        p = re.compile('(?=(%s))' % (i.replace('n', '[ATCG]')))
        for m in p.finditer(seq):
            match_seq = m.group(1)
            if match_seq in frequency:
                frequency[match_seq] += 1
            else:
                frequency.update({match_seq: 1})

    return frequency


# def mutate_kmer(pattern, mutsets):
#     for mutset in mutsets:
#         p = list(pattern)
#         a = 0
#         for i, j in enumerate(p):
#             if j == 'n':
#                 p[i] = mutset[a]
#                 a += 1

#         yield ''.join(p)

def mutate_kmer(pattern, matrix, index):
    if index == len(pattern) - 1:
        if pattern[index] == 'n':
            for b in ['A', 'T', 'C', 'G']:
                if matrix.get(b)[index] != 0:
                    yield b
        else:
            yield pattern[index]
    else:
        if pattern[index] == 'n':
            for b in ['A', 'T', 'C', 'G']:
                if matrix.get(b)[index] != 0:
                    for i in mutate_kmer(pattern, matrix, index + 1):
                        yield b + i
        else:
            for i in mutate_kmer(pattern, matrix, index + 1):
                yield pattern[index] + i


def mutate_kmer2(kmer, index_combinations, mutsets):
    for c in index_combinations:
        for mutset in mutsets:
            change = 1
            mkmer = list(kmer)
            for i, j in zip(c, mutset):
                if mkmer[i] == j:
                    change = 0
                    break
                mkmer[i] = j
            if change:
                yield ''.join(mkmer)


def baseperm(d):
    if d == 1:
        for i in ['A', 'T', 'C', 'G']:
            yield [i]
    else:
        for i in ['A', 'T', 'C', 'G']:
            for j in baseperm(d - 1):
                yield [i] + j


def scan(kmer, seq, d):
    count = 0
    for i in xrange(len(seq) - len(kmer) + 1):
        mismatch = 0
        for a, b in zip(kmer, seq[i: i + len(kmer)]):
            if a != b:
                mismatch += 1
            if mismatch > d:
                break
        if mismatch <= d:
            count += 1

    return count


def kmer_freq(kmer, seq, d):
    count = 0
    for i in xrange(len(seq) - len(kmer) + 1):
        if alignment(kmer, seq[i: i + len(kmer)], d):
            count += 1

    return count


def alignment(kmer_1, kmer_2, d):
    mismatch = 0
    for i, j in zip(kmer_1, kmer_2):
        if i != j:
            mismatch += 1
        if mismatch > d:
            return False

    return True


def aln(a, b):
    for i, j in zip(a, b):
        if i == 'n' or j == 'n':
            continue
        elif i != j:
            return False
    return True


def pattern_merge(patterns):
    # clusters = [0] * len(patterns)
    # n_clusters = 0
    results = []

    for i in xrange(len(patterns)):
        ref = patterns[i]
        # if clusters[i] == 0:
        # n_clusters += 1
        # clusters[i] = n_clusters
        for j in xrange(i + 1, len(patterns)):
            if aln(ref, patterns[j]):
                # clusters[j] = n_clusters
                ref = merge(ref, patterns[j])
        results.append(ref)

    return results


def merge(a, b):
    new_kmer = []
    for i, j in zip(a, b):
        if i != 'n':
            new_kmer.append(i)
        else:
            new_kmer.append(j)

    return ''.join(new_kmer)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq, k, d = fi.readline().split(' ')

    k = int(k)
    d = int(d)

    kmers, masked_kmers = masked_kmers_with_hits(seq, k, d)

    freqs = defaultdict(int)
    for i, j in masked_kmers.iteritems():
        freqs[i] = sum([kmers.get(x) for x in j])

    for i in sorted(freqs, key=lambda x: freqs.get(x), reverse=True):
        print('%s: %s' % (i, freqs.get(i)))

    for i in sorted(masked_kmers, key=lambda x: masked_kmers.get(x), reverse=True):
        print('%s: %s' % (i, masked_kmers.get(i)))

    for i in sorted(kmers, key=lambda x: kmers.get(x), reverse=True):
        print('%s: %s' % (i, kmers.get(i)))

    exit()
    max_pattern_freq = 0
    best_patterns = []
    # for i, j in kmers.iteritems():
    #     if aln(i, 'GCACACAGAC'):
    #         print('%s: %s' % (i, j))

    # skmers = sorted(kmers, key=lambda x: len(kmers.get(x)), reverse=True)

    for i, j in kmers.iteritems():
        # print('%s: %s' % (i, j))
        if len(j) > max_pattern_freq:
            best_patterns = [i]
            max_pattern_freq = len(j)
        elif len(j) == max_pattern_freq:
            best_patterns.append(i)

    # merged = pattern_merge(skmers)
    # for i in merged:
    #     print(i)

    for i in best_patterns:
        print(i)
    exit()
    # for i in xrange(1, d + 1):
    #     index_combinations = [x for x in combinations(xrange(k), i)]

    # max_freq = 0
    # best_kmers = []
    # mutsets = [x for x in baseperm(d)]

    # for i in best_patterns:
    #     for mutkmer in mutate_kmer(i, mutsets):
    #         matches = set()
    #         for c in index_combinations:
    #             mkmer = list(mutkmer)
    #             for x in c:
    #                 mkmer[x] = 'n'
    #             mkmer = ''.join(mkmer)
    #             if mkmer in kmers:
    #                 for m in kmers.get(mkmer):
    #                     matches.add(m)
    #         if len(matches) > max_freq:
    #             best_kmers = [mutkmer]
    #             max_freq = len(matches)
    #         elif len(matches) == max_freq:
    #             best_kmers.append(mutkmer)

    # for i in best_kmers:
    #     print(i)

    # print(max_pattern_freq)

    # matrix_p = {
    #     'A': [0] * k,
    #     'T': [0] * k,
    #     'C': [0] * k,
    #     'G': [0] * k,
    #     'n': [0] * k,
    # }

    # for p in kmers:
    #     for i in xrange(k):
    #         matrix_p[p[i]][i] += 1

    matrix = {
        'A': [0] * k,
        'T': [0] * k,
        'C': [0] * k,
        'G': [0] * k,
    }

    # for i in best_patterns:
    #     print(i)
    # for i in best_patterns:

    # max_kmer_freq = 0
    # best_kmers = []
    # for i, j in find_match_sequences(best_patterns, seq).iteritems():
    #     print('%s: %s' % (i, j))
    #     if j > max_kmer_freq:
    #         best_kmers = [i]
    #         max_kmer_freq = j
    #     elif j == max_kmer_freq:
    #         best_kmers.append(i)

    # for i in best_kmers:
    #     print(i)

    for kmer in find_match_sequences(best_patterns, seq):
        # print(kmer)
        for i in xrange(k):
            matrix[kmer[i]][i] += 1

    max_kmer_freq = 0
    best_kmers = []
    for i in best_patterns:
        for j in mutate_kmer(i, matrix, 0):
            freq = kmer_freq(j, seq, d)
            if freq > max_kmer_freq:
                best_kmers = [j]
                max_kmer_freq = freq
            elif freq == max_kmer_freq:
                best_kmers.append(j)
    for i in best_kmers:
        print(i)
    print('start to index_combination')
    index_combinations = []
    for i in xrange(1, d + 1):
        for x in combinations(xrange(k), i):
            index_combinations.append(x)
    mutsets = [x for x in baseperm(d)]

    mutkmers = set()
    for kmer in best_kmers:
        mutkmers.add(kmer)
        for mutkmer in mutate_kmer2(kmer, index_combinations, mutsets):
            # print(mutkmer)
            mutkmers.add(mutkmer)

    print(len(mutkmers))
    max_freq = 0
    best_kmers = []
    for i in mutkmers:
        freq = scan(i, seq, d)
        if freq > max_freq:
            best_kmers = [i]
            max_freq = freq
        elif freq == max_freq:
            best_kmers.append(i)

    for i in best_kmers:
        print(i)
    print(max_freq)

            # for k in masked_kmers.get(j):
            #     print(kmers.get(k))

    # for i, j in matrix_p.iteritems():
    #     print('%s:\t%s' % (i, '\t'.join([str(x) for x in j])))

    for i, j in matrix.iteritems():
        print('%s:\t%s' % (i, '\t'.join([str(x) for x in j])))


if __name__ == '__main__':
    main()
