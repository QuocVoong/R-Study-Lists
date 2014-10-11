#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        kmers = [i.strip() for i in fi.readlines()]

    for i in overlap_graph(kmers):
        print(i)


def overlap_graph(kmers):
    prefix = {}
    for i in kmers:
        p = i[:-1]
        if p in prefix:
            prefix.get(p).append(i)
        else:
            prefix.update({p: [i]})

    for i in kmers:
        s = i[1:]
        if s in prefix:
            for k in prefix.get(s):
                yield '%s -> %s' % (i, k)


if __name__ == '__main__':
    main()
