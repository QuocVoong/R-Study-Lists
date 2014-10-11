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


def main():
    seqs = []
    with open(sys.argv[1], 'r') as fi:
        for line in fi:
            seqs.append(line.strip())

    seqs = sorted(seqs, key=lambda x: len(x), reverse=True)
    trie, edges = construct_trie(seqs)
    for i, j, k in edges:
        print('{0} {1} {2}'.format(i + 1, j + 1, k))


if __name__ == '__main__':
    main()
