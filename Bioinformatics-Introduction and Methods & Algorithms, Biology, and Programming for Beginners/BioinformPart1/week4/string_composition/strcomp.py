#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        k = int(fi.readline())
        sequence = fi.readline().strip()

    for i in string_composition(sequence, k):
        print(i)


def string_composition(sequence, k):
    kmers = []
    for i in range(len(sequence) - k + 1):
        kmers.append(sequence[i: i + k])

    return sorted(kmers)


if __name__ == '__main__':
    main()
