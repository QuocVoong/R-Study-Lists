#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        source = int(fi.readline())
        sink = int(fi.readline())
        weight = {}
        for line in fi:
            edge, w = line.split(':')
            start, end = [int(x) for x in edge.split('->')]
            if end in weight:
                weight.get(end).update({start: int(w)})
            else:
                weight.update({end: {start: int(w)}})

    # print(weight)
    len_max_path = 0
    max_path = None
    for path, length in generate_all_paths(source, sink, weight):
        if length > len_max_path:
            len_max_path = length
            max_path = path

    max_path.insert(0, sink)
    print(len_max_path)
    print('->'.join([str(x) for x in max_path[::-1]]))


def generate_all_paths(source, start, weight):
    if start in weight:
        for i, j in weight.get(start).items():
            if i == source:
                yield ([i], j)
            else:
                for x, y in generate_all_paths(source, i, weight):
                    yield ([i] + x, j + y)


if __name__ == '__main__':
    main()
