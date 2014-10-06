#!/usr/bin/env python

import sys


def bwt(seq):
    sorted_seqs = sorted(list(generate_rotated_sequences(seq)))
    return ''.join([x[len(seq) - 1] for x in sorted_seqs])


def generate_rotated_sequences(seq):
    double_seq = seq * 2
    for i in range(len(seq)):
        yield double_seq[i: i + len(seq)]


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    bwt_seq = bwt(seq)
    print(bwt_seq)


if __name__ == '__main__':
    main()
