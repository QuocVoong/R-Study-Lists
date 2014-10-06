#!/usr/bin/env python
#
# Usage: $ ./editdist.py <dataset>

import sys
sys.setrecursionlimit(10000)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()
        indel_penalty = 1

    score, backtrack = global_alignment(seq_1, seq_2, indel_penalty)
    # for i in score:
    #     print(i)
    # for i in backtrack:
    #     print(i)

    out_seq_1 = []
    out_seq_2 = []
    outputalign(backtrack, seq_1, seq_2, len(seq_1), len(seq_2), out_seq_1, out_seq_2)
    print(abs(score[len(seq_1)][len(seq_2)]))
    # print(''.join(out_seq_1))
    # print(''.join(out_seq_2))


def global_alignment(seq_1, seq_2, indel_penalty):
    score = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    backtrack = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]

    for i in range(1, len(seq_1) + 1):
        score[i][0] = score[i - 1][0] - indel_penalty

    for j in range(1, len(seq_2) + 1):
        score[0][j] = score[0][j - 1] - indel_penalty

    for i in range(1, len(seq_1) + 1):
        for j in range(1, len(seq_2) + 1):
            if seq_1[i - 1] == seq_2[j - 1]:
                wdiag = 0
            else:
                wdiag = -1
            score[i][j] = max(score[i - 1][j] - indel_penalty,
                              score[i][j - 1] - indel_penalty,
                              score[i - 1][j - 1] + wdiag)

            if score[i][j] == score[i - 1][j] - indel_penalty:
                backtrack[i][j] = 'down'
            elif score[i][j] == score[i][j - 1] - indel_penalty:
                backtrack[i][j] = 'right'
            elif score[i][j] == score[i - 1][j - 1] + wdiag:
                backtrack[i][j] = 'diagonal'

    return score, backtrack


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
