#!/usr/bin/env python

import sys
import re


def mpm(seq, pattern):
    for i in re.finditer(r'(?=({}))'.format(pattern), seq):
        yield i.start()


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        subseqs = []
        for line in fi:
            subseqs.append(line.strip())

    starts = set()
    for i in subseqs:
        for j in mpm(seq, i):
            starts.add(j)

    print(' '.join([str(x) for x in sorted(starts)]))


if __name__ == '__main__':
    main()
