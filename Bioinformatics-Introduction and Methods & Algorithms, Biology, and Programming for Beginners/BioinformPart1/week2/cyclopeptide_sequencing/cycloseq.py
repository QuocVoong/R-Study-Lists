#!/usr/bin/env python

import sys


def aa_spectrum(aa):
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

    if aa in aa_mass:
        return aa_mass.get(aa)
    else:
        return None


def cyclospectrum(spectra):
    """Return the spectra of the cyclopeptide"""
    spec = list(spectra)
    results = []
    for i in range(len(spec)):
        if spec[i]:
            first = spec[i] * 2
            cyclospec = []

            for j in range(len(first) / 2):
                if first[j: j + len(first) / 2] in spec:
                    cyclospec.append(first[j: j + len(first) / 2])
                    spec[spec.index(first[j: j + len(first) / 2])] = None

            if len(cyclospec) == len(first) / 2:
                # Number of cyclic peptides is identical to number of kmers
                for i in cyclospec:
                    results.append('-'.join([str(j) for j in i]))

    return results


def cyclopeptide_sequencing(spectra):
    """Return the possible cyclopeptide of a given spectra"""
    aa = [
        'G',
        'A',
        'S',
        'P',
        'V',
        'T',
        'C',
        'I',
        'L',
        'N',
        'D',
        'Q',
        'K',
        'E',
        'M',
        'H',
        'F',
        'R',
        'Y',
        'W',
    ]

    spectra = [int(i) for i in spectra]
    max_spec = max(spectra)

    k = 1
    kmer = aa
    kmer_next = []
    while True:
        for i in kmer:
            s = [aa_spectrum(j) for j in i]
            if sum(s) in spectra:
                kmer_next.append(i)
        if kmer_next and k <= len(spectra):
            spec = []
            spec_sum = []
            for i in set(kmer_next):
                spec.append('-'.join([str(aa_spectrum(j)) for j in i]))
                spec_sum.append(sum([aa_spectrum(j) for j in i]))
            if max(spec_sum) == max_spec:
                results = cyclospectrum([i.split('-') for i in set(spec)])
                if results:
                    return results
            k += 1
            kmer = []
            for i in kmer_next:
                for a in aa:
                    kmer.append(i + a)
            kmer_next = []
        else:
            break

    return None


def main():
    with open(sys.argv[1], 'r') as fi:
        spectra = fi.readline().strip().split(' ')

    cyclopeptide = cyclopeptide_sequencing(spectra)
    if cyclopeptide:
        print(' '.join(cyclopeptide))


if __name__ == '__main__':
    main()
