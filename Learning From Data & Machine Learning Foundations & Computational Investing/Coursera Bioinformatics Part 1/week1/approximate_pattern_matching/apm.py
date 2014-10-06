#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        kmer = fi.readline().strip()
        seq = fi.readline().strip()
        max_mismatch = int(fi.readline())

    position = []
    for i in range(len(seq) - len(kmer) + 1):
        mismatch = 0
        approx_match = True
        for k, s in zip(kmer, seq[i: i + len(kmer)]):
            if k != s:
                mismatch += 1
                if mismatch > max_mismatch:
                    approx_match = False
                    break
        if approx_match:
            position.append(str(i))

    print(' '.join(position))


if __name__ == '__main__':
    main()
