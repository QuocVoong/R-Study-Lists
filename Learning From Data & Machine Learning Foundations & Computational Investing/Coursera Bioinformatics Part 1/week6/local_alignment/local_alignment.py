#!/usr/bin/env python

import re
import sys
sys.setrecursionlimit(10000)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()
        indel_penalty = 5

    pam = {}
    with open(sys.argv[2], 'r') as fi:
        col = re.split(' +', fi.readline().strip())
        for line in fi:
            data = re.split(' +', line.strip())
            pam.update({data[0]: {col[0]: int(data[1])}})
            for i, j in enumerate(col[1:]):
                pam.get(data[0]).update({j: int(data[i + 2])})

    score, backtrack, max_score_and_cell = local_alignment(seq_1, seq_2, pam, indel_penalty)
    # for i in score:
    #     print(i)
    # for i in backtrack:
    #     print(i)
    # print(max_score_and_cell)

    out_seq_1 = []
    out_seq_2 = []
    outputalign(backtrack, seq_1, seq_2, max_score_and_cell[1], max_score_and_cell[2], out_seq_1, out_seq_2)
    print(max_score_and_cell[0])
    print(''.join(out_seq_1))
    print(''.join(out_seq_2))


def local_alignment(seq_1, seq_2, blosum, indel_penalty):
    score = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    backtrack = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    max_score_and_cell = (0, 0, 0)

    for i in range(1, len(seq_1) + 1):
        score[i][0] = score[i - 1][0] - indel_penalty

    for j in range(1, len(seq_2) + 1):
        score[0][j] = score[0][j - 1] - indel_penalty

    for i in range(1, len(seq_1) + 1):
        for j in range(1, len(seq_2) + 1):
            wdiag = blosum.get(seq_1[i - 1]).get(seq_2[j - 1])
            score[i][j] = max(0,
                              score[i - 1][j] - indel_penalty,
                              score[i][j - 1] - indel_penalty,
                              score[i - 1][j - 1] + wdiag)

            if score[i][j] == score[i - 1][j] - indel_penalty:
                backtrack[i][j] = 'down'
            elif score[i][j] == score[i][j - 1] - indel_penalty:
                backtrack[i][j] = 'right'
            elif score[i][j] == score[i - 1][j - 1] + wdiag:
                backtrack[i][j] = 'diagonal'

            if score[i][j] > max_score_and_cell[0]:
                max_score_and_cell = (score[i][j], i, j)

    return score, backtrack, max_score_and_cell


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
    # elif i == 1 and j == 1:
    #     out_seq_1.append(seq_1[i - 1])
    #     out_seq_2.append(seq_2[j - 1])
    #     return None

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
