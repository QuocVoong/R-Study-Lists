#!/usr/bin/env python

import sys
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-k', type=int, required=True,
                        help='length of k-mer')
    parser.add_argument('-L', type=int, required=True,
                        help='window size')
    parser.add_argument('-t', type=int, required=True,
                        help='minimum frequency of k-mer in a window')
    parser.add_argument('input', nargs='?', default=sys.stdin,
                        help='genome sequence in FASTA format')
    args = parser.parse_args()

    genome = []
    with open(args.input, 'r') as fi:
        for line in fi:
            genome.append(line.rstrip('\n'))
    genome = ''.join(genome)

    clump_kmers = set()
    kmers = {}
    window = genome[0: args.L]
    for i in xrange(args.L - args.k + 1):
        kmer = window[i:i + args.k]
        if kmer in kmers:
            kmers[kmer] += 1
            if kmers.get(kmer) >= args.t:
                clump_kmers.add(kmer)
        else:
            kmers.update({kmer: 1})

    first_kmer = window[0: args.k]
    for i in xrange(1, len(genome) - args.L + 1):
        if first_kmer in kmers:
            kmers[first_kmer] -= 1
            if kmers.get(first_kmer) == 0:
                kmers.pop(first_kmer)

        window = genome[i: i + args.L]
        first_kmer = window[0: args.k]
        kmer = window[-args.k:]
        if kmer in kmers:
            kmers[kmer] += 1
            if kmers.get(kmer) >= args.t:
                clump_kmers.add(kmer)
        else:
            kmers.update({kmer: 1})

    for i in clump_kmers:
        print(i)


if __name__ == '__main__':
    main()
