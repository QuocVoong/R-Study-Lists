#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        kmer = int(fi.readline().strip())

    freqwords = {}
    for i in range(len(seq)):
        if i < len(seq) - kmer:
            subs = seq[i: i + kmer]
            if subs in freqwords:
                freqwords[subs] += 1
            else:
                freqwords.update({subs: 1})

    mostfreqwords = []
    freq = 0
    for i, j in freqwords.iteritems():
        if j > freq:
            mostfreqwords = [i]
            freq = j
        elif j == freq:
            mostfreqwords.append(i)

    print(' '.join(mostfreqwords))


if __name__ == '__main__':
    main()
