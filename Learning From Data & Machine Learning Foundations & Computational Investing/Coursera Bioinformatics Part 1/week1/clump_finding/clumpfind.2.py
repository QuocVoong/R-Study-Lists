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

    high_freq_kmers = set()
    starts = {}
    ends = {}
    for i in xrange(len(genome) - args.k):
        kmer = genome[i: i + args.k]

        if kmer in high_freq_kmers:
            continue
        elif kmer in starts:
            starts.get(kmer).append(i)
            ends.get(kmer).append(i + args.k - 1)
            if len(starts.get(kmer)) > 2:
                freq = 1
                for i in starts.get(kmer)[::-2]:
                    if ends.get(kmer)[-1] - i + 1 <= args.L:
                        freq += 1
                        if freq == args.t:
                            high_freq_kmers.add(kmer)
                            break
                    else:
                        break
            elif len(starts.get(kmer)) >= args.t:
                high_freq_kmers.add(kmer)
        else:
            starts.update({kmer: [i]})
            ends.update({kmer: [i + args.k - 1]})

    for i in high_freq_kmers:
        print(i)


if __name__ == '__main__':
    main()
