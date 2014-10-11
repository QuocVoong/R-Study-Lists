#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    print(revcomp(seq))


def revcomp(seq):
    table = {
        'A': 'T',
        'T': 'A',
        'C': 'G',
        'G': 'C',
    }
    rc_seq = []
    for i in seq[::-1]:
        rc_seq.append(table.get(i))

    return ''.join(rc_seq)


if __name__ == '__main__':
    main()
