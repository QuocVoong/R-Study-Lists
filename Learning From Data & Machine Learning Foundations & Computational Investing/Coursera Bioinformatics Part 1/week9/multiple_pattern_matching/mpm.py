#!/usr/bin/env python

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


def main():
    with open(sys.argv[1], 'r') as fi:
        genome = fi.readline().strip()
        dna = []
        for line in fi:
            dna.append(line.strip())

    trie, edges = construct_trie(dna)
    indices = trie_matching(genome, trie)
    print(' '.join([str(x) for x in indices]))


if __name__ == '__main__':
    main()
