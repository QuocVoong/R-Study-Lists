#!/usr/bin/env python
#
# Usage: $ ./global_alignment.py <dataset> <blosum>

import re
import sys
sys.setrecursionlimit(10000)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()
    gap_open_penalty = 11
    gap_extend_penalty = 1
    blosum = {}
    with open(sys.argv[2], 'r') as fi:
        col = re.split(' +', fi.readline().strip())
        for line in fi:
            data = re.split(' +', line.strip())
            blosum.update({data[0]: {col[0]: int(data[1])}})
            for i, j in enumerate(col[1:]):
                blosum.get(data[0]).update({j: int(data[i + 2])})

    lower, upper, middle, backtrack = affine_alignment(seq_1, seq_2, blosum, gap_open_penalty, gap_extend_penalty)

    i = len(seq_1)
    j = len(seq_2)
    # print(i)
    # print(j)
    max_score = max(lower[i][j], upper[i][j], middle[i][j])
    if lower[i][j] == max_score:
        start = 'lower'
    if upper[i][j] == max_score:
        start = 'upper'
    if middle[i][j] == max_score:
        start = 'middle'

    out_seq_1 = []
    out_seq_2 = []
    outputlcs(backtrack, seq_1, seq_2, len(seq_1), len(seq_2), start, out_seq_1, out_seq_2)

    print(max_score)
    print(''.join(out_seq_1))
    print(''.join(out_seq_2))


def affine_alignment(seq_1, seq_2, blosum, gap_open_penalty, gap_extend_penalty):
    lower = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    upper = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    middle = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    btlower = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    btupper = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    btmiddle = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    backtrack = {'lower': btlower, 'upper': btupper, 'middle': btmiddle}

    for i in range(1, len(seq_1) + 1):
        middle[i][0] = 0 - gap_open_penalty - gap_extend_penalty * (i - 1)
    for j in range(1, len(seq_2) + 1):
        middle[0][j] = 0 - gap_open_penalty - gap_extend_penalty * (j - 1)

    for i in range(1, len(seq_1) + 1):
        lower[i][0] = 0 - gap_open_penalty - gap_extend_penalty * (i - 1)
    for j in range(1, len(seq_2) + 1):
        lower[0][j] = float('-inf')
    lower[0][0] = float('-inf')

    for i in range(1, len(seq_1) + 1):
        upper[i][0] = float('-inf')
    for j in range(1, len(seq_2) + 1):
        upper[0][j] = 0 - gap_open_penalty - gap_extend_penalty * (j - 1)
    upper[0][0] = float('-inf')

    for i in range(1, len(seq_1) + 1):
        for j in range(1, len(seq_2) + 1):
            wdiag = blosum.get(seq_1[i - 1]).get(seq_2[j - 1])
            lower[i][j] = max(lower[i - 1][j] - gap_extend_penalty, middle[i - 1][j] - gap_open_penalty)
            upper[i][j] = max(upper[i][j - 1] - gap_extend_penalty, middle[i][j - 1] - gap_open_penalty)
            middle[i][j] = max(lower[i][j], middle[i - 1][j - 1] + wdiag, upper[i][j])

            if lower[i][j] == lower[i - 1][j] - gap_extend_penalty:
                btlower[i][j] = 'lower'
            if lower[i][j] == middle[i - 1][j] - gap_open_penalty:
                btlower[i][j] = 'middle'

            if upper[i][j] == upper[i][j - 1] - gap_extend_penalty:
                btupper[i][j] = 'upper'
            if upper[i][j] == middle[i][j - 1] - gap_open_penalty:
                btupper[i][j] = 'middle'

            if middle[i][j] == middle[i - 1][j - 1] + wdiag:
                btmiddle[i][j] = 'middle'
            if middle[i][j] == lower[i][j]:
                btmiddle[i][j] = 'lower'
            if middle[i][j] == upper[i][j]:
                btmiddle[i][j] = 'upper'

    return lower, upper, middle, backtrack


def outputlcs(backtrack, v, w, i, j, layer, result_v, result_w):
    if i == 1 and j != 1:
        for x in range(1, j):
            result_v.append('-')
            result_w.append(w[x - 1])
        result_v.append(v[i - 1])
        result_w.append(w[j - 1])
        return None

    elif i != 1 and j == 1:
        for x in range(1, i):
            result_v.append(v[x - 1])
            result_w.append('-')
        result_v.append(v[i - 1])
        result_w.append(w[j - 1])
        return None
    elif i == 1 and j == 1:
        result_v.append(v[i - 1])
        result_w.append(w[j - 1])
        return None

    if backtrack.get(layer)[i][j] == 'lower':
        outputlcs(backtrack, v, w, i - 1, j, backtrack.get(layer)[i - 1][j], result_v, result_w)
        result_v.append(v[i - 1])
        result_w.append('-')
    elif backtrack.get(layer)[i][j] == 'upper':
        outputlcs(backtrack, v, w, i, j - 1, backtrack.get(layer)[i][j - 1], result_v, result_w)
        result_v.append('-')
        result_w.append(w[j - 1])
    elif backtrack.get(layer)[i][j] == 'middle':
        outputlcs(backtrack, v, w, i - 1, j - 1, backtrack.get(layer)[i - 1][j - 1], result_v, result_w)
        result_v.append(v[i - 1])
        result_w.append(w[j - 1])


def outputalign(backtrack, seq_1, seq_2, i, j, out_seq_1, out_seq_2):
    if i == 1 and j != 1:
        for x in reversed(range(1, j)):
            out_seq_1.append('-')
            out_seq_2.append(seq_2[x - 1])
        out_seq_1.append(seq_1[i - 1])
        out_seq_2.append(seq_2[j - 1])
        return None

    elif i != 1 and j == 1:
        for x in reversed(range(1, i)):
            out_seq_1.append(seq_1[x - 1])
            out_seq_2.append('-')
        out_seq_1.append(seq_1[i - 1])
        out_seq_2.append(seq_2[j - 1])
        return None
    elif i == 1 and j == 1:
        out_seq_1.append(seq_1[i - 1])
        out_seq_2.append(seq_2[j - 1])
        return None

    if 'down' == backtrack[i][j]:
        outputalign(backtrack, seq_1, seq_2, i - 1, j, out_seq_1, out_seq_2)
        out_seq_1.append(seq_1[i - 1])
        out_seq_2.append('-')
    elif 'right' == backtrack[i][j]:
        outputalign(backtrack, seq_1, seq_2, i, j - 1, out_seq_1, out_seq_2)
        out_seq_1.append('-')
        out_seq_2.append(seq_2[j - 1])
    elif 'diagonal' == backtrack[i][j]:
        outputalign(backtrack, seq_1, seq_2, i - 1, j - 1, out_seq_1, out_seq_2)
        out_seq_1.append(seq_1[i - 1])
        out_seq_2.append(seq_2[j - 1])


if __name__ == '__main__':
    main()
