#!/usr/bin/env python

import re
import sys
from math import floor


def main():
    with open(sys.argv[1], 'r') as fi:
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()
        indel_penalty = 5
    blosum = {}
    with open(sys.argv[2], 'r') as fi:
        col = re.split(' +', fi.readline().strip())
        for line in fi:
            data = re.split(' +', line.strip())
            blosum.update({data[0]: {col[0]: int(data[1])}})
            for i, j in enumerate(col[1:]):
                blosum.get(data[0]).update({j: int(data[i + 2])})

    start = (0, 0)
    end = (len(seq_1) - 1, len(seq_2) - 1)
    score, backtrack, max_score, max_i, max_j = global_alignment(seq_1, seq_2, blosum, indel_penalty, start, end)

    if backtrack[max_i][max_j] == 'diagonal':
        pre_i = max_i - 1
        pre_j = max_j - 1
    elif backtrack[max_i][max_j] == 'right':
        pre_i = max_i
        pre_j = max_j - 1

    print('({0}, {1}) ({2}, {3})'.format(pre_i, pre_j, max_i, max_j))


def global_alignment(seq_1, seq_2, blosum, indel_penalty, start, end):
    score = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    backtrack = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]

    for i in range(start[0], end[0] + 1):
        score[i][0] = score[i - 1][0] - indel_penalty

    for j in range(start[1], end[1] + 1):
        score[0][j] = score[0][j - 1] - indel_penalty

    # middle_node_1 = floor((end[0] - start[0]) / 2), floor((end[1] - start[1]) / 2)
    # middle_node_2 = middle_node_1[0] + 1, middle_node_1[1] + 1
    max_score = float('-inf')
    max_i = 0
    max_j = 0
    for i in range(start[0] + 1, end[0] + 2):
        for j in range(start[1] + 1, int(floor((end[1] - start[1]) / 2)) + 2):
            wdiag = blosum.get(seq_1[i - 1]).get(seq_2[j - 1])
            score[i][j] = max(score[i - 1][j] - indel_penalty,
                              score[i][j - 1] - indel_penalty,
                              score[i - 1][j - 1] + wdiag)

            if score[i][j] == score[i - 1][j] - indel_penalty:
                backtrack[i][j] = 'down'
            elif score[i][j] == score[i][j - 1] - indel_penalty:
                backtrack[i][j] = 'right'
            elif score[i][j] == score[i - 1][j - 1] + wdiag:
                backtrack[i][j] = 'diagonal'

            if score[i][j] > max_score:
                max_score = score[i][j]
                max_i = i
                max_j = j

    return score, backtrack, max_score, max_i, max_j


def consecutive_nodes(k, n):
    for i in range(k - n + 1):
        yield (i, i + 1)


if __name__ == '__main__':
    main()
