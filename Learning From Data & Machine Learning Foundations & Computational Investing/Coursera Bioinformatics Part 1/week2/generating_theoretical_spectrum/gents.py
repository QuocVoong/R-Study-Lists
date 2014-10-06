#!/usr/bin/env python

import sys


def main():
    aa_mass = {
        'G': 57,
        'A': 71,
        'S': 87,
        'P': 97,
        'V': 99,
        'T': 101,
        'C': 103,
        'I': 113,
        'L': 113,
        'N': 114,
        'D': 115,
        'Q': 128,
        'K': 128,
        'E': 129,
        'M': 131,
        'H': 137,
        'F': 147,
        'R': 156,
        'Y': 163,
        'W': 186,
    }

    with open(sys.argv[1], 'r') as fi:
        peptide = fi.readline().strip()

    ts = [0]
    # Step
    for i in range(1, len(peptide) + 1):
        extended_peptide = peptide
        # Start
        for j in range(len(peptide)):
            if j + i > len(extended_peptide):
                extended_peptide += peptide
            _ts = 0
            # print(extended_peptide[j: j + i])
            for k in extended_peptide[j: j + i]:
                _ts += aa_mass.get(k)
            ts.append(_ts)
            if i == len(peptide):
                break

    ts.sort()
    print(' '.join([str(i) for i in ts]))


if __name__ == '__main__':
    main()
