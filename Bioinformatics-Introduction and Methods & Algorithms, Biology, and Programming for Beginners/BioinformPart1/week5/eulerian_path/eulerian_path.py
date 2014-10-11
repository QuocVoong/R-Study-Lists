#!/usr/bin/env python

import sys
from collections import defaultdict


def main():
    with open(sys.argv[1], 'r') as fi:
        edges = []
        for line in fi:
            data = line.strip().split(' -> ')
            for i in data[1].split(','):
                edges.append((int(data[0]), int(i)))

    link_edge = get_edge_of_path_to_cycle(edges)
    edges.append(link_edge)
    cycle = eulerian_cycle(edges)
    path = cycle_to_path(cycle, link_edge)
    print('->'.join([str(i) for i in path]))


def get_edge_of_path_to_cycle(edges):
    entries = defaultdict(int)
    exits = defaultdict(int)
    nodes = set()
    for i, j in edges:
        nodes.add(i)
        nodes.add(j)
        entries[j] += 1
        exits[i] += 1

    for i in nodes:
        if entries.get(i) > exits.get(i):
            start = i
        elif entries.get(i) < exits.get(i):
            end = i

    return (start, end)


def cycle_to_path(cycle, edge):
    for i in range(len(cycle)):
        if (cycle[i], cycle[i + 1]) == edge:
            return cycle[i + 1:len(cycle) - 1] + cycle[:i + 1]


def eulerian_cycle(edges):
    graph = {}
    traverse = {}
    for i, j in edges:
        if i in graph:
            graph[i].append(j)
        else:
            graph.update({i: [j]})
        traverse.update({(i, j): 0})

    cycle, traverse = form_cycle(graph, traverse)
    while not all(traverse.values()):
        cycle, traverse = form_cycle(graph, traverse, cycle)

    return cycle


def form_cycle(graph, traverse, cycle=None):
    if cycle:
        start = find_start(graph, traverse, cycle)
        expand = cycle + cycle[1:]
        new_cycle = []
        for i in range(cycle.index(start), cycle.index(start) + len(cycle)):
            new_cycle.append(expand[i])
    else:
        start = graph.keys()[0]
        new_cycle = [start]

    while 1:
        get_path = False
        for i in graph.get(start):
            if traverse.get((start, i)) == 0:
                get_path = True
                traverse[(start, i)] = 1
                new_cycle.append(i)
                start = i
            if get_path:
                break
        if not get_path:
            break

    return new_cycle, traverse


def find_start(graph, traverse, cycle):
    for i in cycle:
        for j in graph.get(i):
            if not traverse.get((i, j)):
                return i


if __name__ == '__main__':
    main()
