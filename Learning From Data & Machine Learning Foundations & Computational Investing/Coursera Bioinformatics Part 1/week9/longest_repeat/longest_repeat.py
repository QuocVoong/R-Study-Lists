#!/usr/bin/env python
#
# This algorithm comsumes huge memory when k is large.
# Set k = 500 and use the binary search apporach for
# a work-around.

import sys


def construct_trie(seqs):
    trie = [{}]
    edges = []

    w = 1
    for i in seqs:
        v = 0
        for j in i:
            if j in trie[v]:
                v = trie[v].get(j)
            else:
                trie[v].update({j: w})
                edges.append((v, w, j))
                trie.append({})
                v = w
                w += 1

    return trie, edges


def trie_matching(genome, trie):
    indices = []
    for i, j in enumerate(genome):
        start_genome = i
        start = 0
        while 1:
            if j in trie[start]:
                start = trie[start].get(j)
                if not trie[start]:
                    indices.append(i)
                    break
                start_genome += 1
                if start_genome < len(genome):
                    j = genome[start_genome]
                else:
                    break
            else:
                if not trie[start]:
                    indices.append(i)
                break

    return indices


def longest_repeat(seq):
    left = 1
    right = 500
    mid = right / 2

    while 1:
        if mid == left or mid == right:
            break
        s = '-'
        kmers = set()
        for kmer in generate_kmers(seq, mid):
            kmers.add(kmer)
        trie, edges = construct_trie(kmers)
        indices = trie_matching(seq, trie)
        if len(indices) > len(kmers):
            longest_kmers = kmers
            left = mid
            mid += (right - mid) / 2
            s = '+'

        if s == '-':
            right = mid
            mid -= (mid - left) / 2

    for i in longest_kmers:
        if seq.count(i) > 1:
            return i


def generate_kmers(seq, k):
    for i in xrange(len(seq) - k + 1):
        yield seq[i: i + k]


def generate_suffixes(seq):
    for i in range(len(seq)):
        yield seq[i:]


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    result = longest_repeat(seq)
    print(result)


if __name__ == '__main__':
    main()
