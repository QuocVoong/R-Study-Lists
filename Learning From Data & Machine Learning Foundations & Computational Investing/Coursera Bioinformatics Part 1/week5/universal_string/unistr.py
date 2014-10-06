#!/usr/bin/env python

import sys
from itertools import product
from debruijngraph import overlap_graph


def main():
    with open(sys.argv[1], 'r') as fi:
        k = int(fi.read())

    kmers = [''.join(x) for x in list(product('01', repeat=k - 1))]

    edges = []
    for i in overlap_graph(kmers):
        data = i.split(' -> ')
        for i in data[1].split(','):
            edges.append((data[0], i))

    small, large = classify_edges(edges)
    origin = '0' * (k - 1)
    start = large.get(origin)
    cycle_edges = [(origin, small.get(origin)), (origin, start)]
    while 1:
        if start in large:
            cycle_edges.append((start, large.get(start)))
            end = large.get(start)
            large.pop(start)
            start = end
        elif start in small:
            cycle_edges.append((start, small.get(start)))
            end = small.get(start)
            small.pop(start)
            start = end
        else:
            break

    print(glue(cycle_edges))


def glue(edges):
    k = len(edges[0][0])
    string = [edges[0][0] + edges[0][1][-1]]
    for i, j in edges[1:]:
        string.append(j[-1])

    return ''.join(string[:-(k + 1)])


def classify_edges(edges):
    small_edges = {}
    large_edges = {}
    for i, j in edges:
        if i in small_edges:
            large_edges.update({i: j})
        else:
            small_edges.update({i: j})

    return small_edges, large_edges


if __name__ == '__main__':
    main()
