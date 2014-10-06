#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        kmer, windowsize, times = [int(i) for i in fi.readline().strip().split(' ')]

    clumpseq = set()
    for i in range(len(seq) - windowsize):
        subseq = seq[i: i + windowsize]
        clumps = {}
        for j in range(len(subseq) - kmer):
            ssubseq = subseq[j: j + kmer]
            if ssubseq in clumps:
                clumps[ssubseq] += 1
            else:
                clumps.update({ssubseq: 1})
        for key, value in clumps.iteritems():
            if value == times:
                clumpseq.add(key)

    print(' '.join(clumpseq))


if __name__ == '__main__':
    main()
