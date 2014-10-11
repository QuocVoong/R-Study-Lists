#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        p = []
        for i in fi.readline().split(')('):
            p.append([int(x) for x in i.strip('\n()').split(' ')])
        q = []
        for i in fi.readline().split(')('):
            q.append([int(x) for x in i.strip('\n()').split(' ')])

    dist = two_break_distance(p, q)
    print(dist)


def two_break_distance(p, q):
    p_edges = []
    for i in p:
        i = i + [i[0]]
        p_edges += get_edge(i)

    q_edges = []
    for i in q:
        i = i + [i[0]]
        q_edges += get_edge(i)

    nblocks = len(p_edges)
    cycles = []
    while p_edges:
        cycles.append(find_cycle(p_edges, q_edges))

    return nblocks - len(cycles)


def get_edge(p):
    edges = []
    for i in range(len(p) - 2 + 1):
        edges.append((p[i], -p[i + 1]))

    return edges


def find_cycle(p_edges, q_edges):
    cycle = [p_edges.pop(0)]
    current = 'q'
    edges = q_edges
    while not is_cycle(cycle):
        for i in edges:
            if cycle[-1][-1] == i[0]:
                cycle.append(i)
                edges.remove(i)
                if current == 'p':
                    current = 'q'
                    edges = q_edges
                else:
                    current = 'p'
                    edges = p_edges
                break
            elif cycle[-1][-1] == i[1]:
                cycle.append((i[1], i[0]))
                edges.remove(i)
                if current == 'p':
                    current = 'q'
                    edges = q_edges
                else:
                    current = 'p'
                    edges = p_edges
                break

    return cycle


def is_cycle(cycle):
    if cycle[0][0] == cycle[-1][-1]:
        return True
    else:
        return False


if __name__ == '__main__':
    main()
