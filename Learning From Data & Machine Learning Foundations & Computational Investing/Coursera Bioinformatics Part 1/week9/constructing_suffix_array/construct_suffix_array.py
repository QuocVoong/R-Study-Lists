#!/usr/bin/env python

import sys


def construct_suffix_array(seq):
    suffix_array = sorted(range(len(seq)), cmp=lambda x, y: cmp(seq[x:], seq[y:]))

    return suffix_array


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    suffix_array = construct_suffix_array(seq)
    print(', '.join([str(x) for x in suffix_array]))


if __name__ == '__main__':
    main()
