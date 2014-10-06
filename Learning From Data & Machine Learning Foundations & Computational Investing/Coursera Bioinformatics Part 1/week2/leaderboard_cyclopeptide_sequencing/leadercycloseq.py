#!/usr/bin/env python

import sys


def expand(spectrum=None):
    mass = [
        57,
        71,
        87,
        97,
        99,
        101,
        103,
        113,
        114,
        115,
        128,
        129,
        131,
        137,
        147,
        156,
        163,
        186,
    ]
    if spectrum:
        spectrum_ext = []
        for i in spectrum:
            for j in mass:
                spectrum_ext.append(i + (j,))
        return spectrum_ext
    else:
        return [(i,) for i in mass]


def cyclospectrum(spectrum):
    """Return the spectra of the cyclopeptide"""
    spec = spectrum * 2

    for i in range(len(spectrum)):
        for j in range(i, i + len(spectrum)):
            yield(spec[i:j])


def score(peptide, spectrum):
    spec = list(spectrum)
    s = 0

    for j in cyclospectrum(peptide):
        if sum(j) in spec:
            s += 1
            spec.remove(sum(j))

    return s


def cut(leaderboard, spectrum, n):
    scores = {}
    for peptide in leaderboard:
        if peptide:
            scores.update({peptide: score(peptide, spectrum)})
    if not scores:
        return []
    rank = 1
    new_peptides = []
    ranked_peptides = sorted(scores, key=lambda x: scores.get(x), reverse=True)
    prepep = ranked_peptides[0]
    new_peptides.append(prepep)
    for i in ranked_peptides[1:]:
        if rank > n and scores.get(i) == scores.get(prepep):
            new_peptides.append(i)
        elif rank > n:
            break
        else:
            new_peptides.append(i)
            rank += 1
            prepep = i

    return new_peptides


def leaderboard_cyclopeptide_sequencing(spectrum, n, limit_spec=None):
    mass = [
        57,
        71,
        87,
        97,
        99,
        101,
        103,
        113,
        114,
        115,
        128,
        129,
        131,
        137,
        147,
        156,
        163,
        186,
    ]
    leaderboard = [(i,) for i in mass]
    if limit_spec:
        new_leaderboard = []
        for i in leaderboard:
            if i[0] in limit_spec:
                new_leaderboard.append(i)
        leaderboard = new_leaderboard
    leaderpeptide = None
    max_mass = max(spectrum)
    while leaderboard:
        leaderboard = expand(leaderboard)
        for i, j in enumerate(leaderboard):
            if sum(j) == max_mass:
                if leaderpeptide:
                    if score(j, spectrum) > score(leaderpeptide, spectrum):
                        leaderpeptide = j
                else:
                    leaderpeptide = j
            elif sum(j) > max_mass:
                leaderboard[i] = 0
        leaderboard = cut(leaderboard, spectrum, n)

    return leaderpeptide


def main():
    with open(sys.argv[1], 'r') as fi:
        n = int(fi.readline().strip())
        spectrum = [int(i) for i in fi.readline().strip().split(' ')]

    leadercyclopeptide = leaderboard_cyclopeptide_sequencing(spectrum, n)
    if leadercyclopeptide:
        print('-'.join([str(i) for i in leadercyclopeptide]))


if __name__ == '__main__':
    main()
