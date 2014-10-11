#!/usr/bin/env python

import sys


def main():
    codon_table = {}
    with open('RNA_codon_table_1.txt', 'r') as fi:
        for line in fi:
            codon, aa = line.rstrip('\n').split(' ')
            codon_table.update({codon: aa})

    with open(sys.argv[1], 'r') as fi:
        while True:
            codon = fi.read(3)
            if codon in codon_table:
                sys.stdout.write(codon_table.get(codon))
            else:
                break
        sys.stdout.write('\n')


if __name__ == '__main__':
    main()
