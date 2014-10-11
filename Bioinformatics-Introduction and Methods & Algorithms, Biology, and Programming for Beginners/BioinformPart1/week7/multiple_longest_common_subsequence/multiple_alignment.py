#!/usr/bin/env python

import sys
sys.setrecursionlimit(10000)


def main():
    with open(sys.argv[1], 'r') as fi:
        v = fi.readline().strip()
        w = fi.readline().strip()
        y = fi.readline().strip()

    s, backtrack, max_score = lcs(v, w, y)

    out_v = []
    out_w = []
    out_y = []
    outputlcs(backtrack, v, w, y, len(v), len(w), len(y), out_v, out_w, out_y)

    print(max_score)
    print(''.join(out_v))
    print(''.join(out_w))
    print(''.join(out_y))


def lcs(v, w, y):
    s = [[[0 for x in range(len(y) + 1)] for x in range(len(w) + 1)] for x in range(len(v) + 1)]
    backtrack = [[[0 for x in range(len(y) + 1)] for x in range(len(w) + 1)] for x in range(len(v) + 1)]
    max_score = float('-inf')

    for i in range(1, len(v) + 1):
        for j in range(1, len(w) + 1):
            for k in range(1, len(y) + 1):
                if v[i - 1] == w[j - 1] == y[k - 1]:
                    s_diag = s[i - 1][j - 1][k - 1] + 1
                else:
                    s_diag = s[i - 1][j - 1][k - 1]
                s[i][j][k] = max(s[i - 1][j][k],
                                 s[i][j - 1][k],
                                 s[i][j][k - 1],
                                 s[i - 1][j - 1][k],
                                 s[i - 1][j][k - 1],
                                 s[i][j - 1][k - 1],
                                 s_diag)

                if s[i][j][k] == s[i - 1][j][k]:
                    backtrack[i][j][k] = 1
                if s[i][j][k] == s[i][j - 1][k]:
                    backtrack[i][j][k] = 2
                if s[i][j][k] == s[i][j][k - 1]:
                    backtrack[i][j][k] = 3
                if s[i][j][k] == s[i - 1][j - 1][k]:
                    backtrack[i][j][k] = 4
                if s[i][j][k] == s[i - 1][j][k - 1]:
                    backtrack[i][j][k] = 5
                if s[i][j][k] == s[i][j - 1][k - 1]:
                    backtrack[i][j][k] = 6
                if s[i][j][k] == s_diag:
                    backtrack[i][j][k] = 7

                if s[i][j][k] > max_score:
                    max_score = s[i][j][k]

    return s, backtrack, max_score


def outputlcs(backtrack, v, w, y, i, j, k, out_v, out_w, out_y):
    if i <= 1 and j <= 1 and k <= 1:
        if i == 0:
            out_v.append('-')
        else:
            out_v.append(v[i - 1])

        if j == 0:
            out_w.append('-')
        else:
            out_w.append(w[j - 1])

        if k == 0:
            out_y.append('-')
        else:
            out_y.append(y[k - 1])

        return None

    if 1 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i - 1, j, k, out_v, out_w, out_y)
        out_v.append(v[i - 1])
        out_w.append('-')
        out_y.append('-')
    elif 2 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i, j - 1, k, out_v, out_w, out_y)
        out_v.append('-')
        out_w.append(w[j - 1])
        out_y.append('-')
    elif 3 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i, j, k - 1, out_v, out_w, out_y)
        out_v.append('-')
        out_w.append('-')
        out_y.append(y[k - 1])
    elif 4 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i - 1, j - 1, k, out_v, out_w, out_y)
        out_v.append(v[i - 1])
        out_w.append(w[j - 1])
        out_y.append('-')
    elif 5 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i - 1, j, k - 1, out_v, out_w, out_y)
        out_v.append(v[i - 1])
        out_w.append('-')
        out_y.append(y[k - 1])
    elif 6 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i, j - 1, k - 1, out_v, out_w, out_y)
        out_v.append('-')
        out_w.append(w[j - 1])
        out_y.append(y[k - 1])
    elif 7 == backtrack[i][j][k]:
        outputlcs(backtrack, v, w, y, i - 1, j - 1, k - 1, out_v, out_w, out_y)
        out_v.append(v[i - 1])
        out_w.append(w[j - 1])
        out_y.append(y[k - 1])


if __name__ == '__main__':
    main()
