#!/usr/bin/env python

import sys
sys.setrecursionlimit(10000)


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


def generate_suffix(seq):
    for i in range(len(seq)):
        yield seq[i:]


def construct_suffix_tree(trie, level, edge_label):
    for i, j in trie[level].items():
        if not trie[j]:
            edge_label.append(i)
            yield ''.join(edge_label)
            edge_label = []
        elif len(trie[j]) > 1:
            edge_label.append(i)
            yield ''.join(edge_label)
            edge_label = []
            for k in construct_suffix_tree(trie, j, edge_label):
                yield k
            edge_label = []
        elif len(trie[j]) == 1:
            edge_label.append(i)
            for k in construct_suffix_tree(trie, j, edge_label):
                yield k
            edge_label = []


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    suffixes = list(generate_suffix(seq))
    trie, edges = construct_trie(suffixes)
    edge_label = []
    for i in construct_suffix_tree(trie, 0, edge_label):
        print(i)


if __name__ == '__main__':
    main()
