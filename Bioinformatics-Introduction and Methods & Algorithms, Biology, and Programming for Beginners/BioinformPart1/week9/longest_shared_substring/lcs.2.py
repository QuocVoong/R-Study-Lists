#!/usr/bin/env python
# This solution is from http://www.daimi.au.dk/~mailund/suffix_tree.html

import sys
from suffix_tree import GeneralisedSuffixTree


def main():
    with open(sys.argv[1], 'r') as fi:
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()

    seqs = [seq_1, seq_2]
    stree = GeneralisedSuffixTree(seqs)

    max_len = 0
    max_str = ''
    for shared in stree.sharedSubstrings():
        for seq, start, stop in shared:
            cs = seqs[seq][start:stop]
            if len(cs) > max_len:
                max_len = len(cs)
                max_str = cs

    print(max_str)


if __name__ == '__main__':
    main()
