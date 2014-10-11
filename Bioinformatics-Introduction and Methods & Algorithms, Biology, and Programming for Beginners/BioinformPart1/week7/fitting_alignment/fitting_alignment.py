#!/usr/bin/env python
#
# Usage: $ ./fitting_alignment.py <dataset>

import sys
sys.setrecursionlimit(10000)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq_1 = fi.readline().strip()
        seq_2 = fi.readline().strip()
        indel_penalty = 1

    max_score = 0
    max_out_seq_1 = ''
    max_out_seq_2 = ''
    for k in range(len(seq_2), len(seq_2) + 15):
        for kmer in generate_kmers(seq_1, k):
            out_seq_1 = []
            out_seq_2 = []
            score, backtrack = fitting_alignment(kmer, seq_2, indel_penalty)
            outputalign(backtrack, kmer, seq_2, len(kmer), len(seq_2), out_seq_1, out_seq_2)
            # print(score[len(kmer)][len(seq_2)])
            # print(''.join(out_seq_1))
            # print(''.join(out_seq_2))
            if score[len(kmer)][len(seq_2)] > max_score:
                max_score = score[len(kmer)][len(seq_2)]
                max_out_seq_1 = ''.join(out_seq_1)
                max_out_seq_2 = ''.join(out_seq_2)

    print(max_score)
    print(max_out_seq_1)
    print(max_out_seq_2)


def generate_kmers(seq, k):
    for i in range(len(seq) - k + 1):
        yield seq[i: i + k]


def fitting_alignment(seq_1, seq_2, indel_penalty):
    score = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]
    backtrack = [[0 for x in range(len(seq_2) + 1)] for x in range(len(seq_1) + 1)]

    for i in range(1, len(seq_1) + 1):
        score[i][0] = score[i - 1][0] - indel_penalty

    for j in range(1, len(seq_2) + 1):
        score[0][j] = score[0][j - 1] - indel_penalty

    for i in range(1, len(seq_1) + 1):
        for j in range(1, len(seq_2) + 1):
            if seq_1[i - 1] == seq_2[j - 1]:
                wdiag = 1
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
