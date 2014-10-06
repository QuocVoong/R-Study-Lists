#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        kmers = []
        for line in fi:
            kmers.append(line.strip())

    precontigs = []
    for i in contig_generation(kmers):
        precontigs.append(i)

    for i in precontigs:
        if not any([i != x and i in x for x in precontigs]):
            print(i)


def gen_edges(sequences, k):
    edges = []
    for sequence in sequences:
        for i in range(len(sequence) - k + 1):
            edges.append((sequence[i: i + k][:-1], sequence[i: i + k][1:]))

    return edges


def contig_generation(kmers):
    edges = gen_edges(kmers, len(kmers[0]))

    nodemap = {}
    enode_count = {}
    for i, j in edges:
        if i in nodemap:
            nodemap.get(i).append(j)
        else:
            nodemap[i] = [j]
        if j in enode_count:
            enode_count[j] += 1
        else:
            enode_count[j] = 1

    for i, j in nodemap.items():
        for contig in gen_branches(i, j, nodemap, enode_count):
            yield contig


def gen_branches(snode, enodes, nodemap, enode_count):
    for i in enodes:
        if i in nodemap and len(nodemap.get(i)) == 1 and enode_count.get(i) == 1:
            for j in gen_branches(i, nodemap.get(i), nodemap, enode_count):
                yield concat(snode, j)
        else:
            yield concat(snode, i)


def concat(snode, enode):
    return snode[0] + enode


if __name__ == '__main__':
    main()
