#!/usr/bin/env python

import sys
sys.setrecursionlimit(10000)


def main():
    with open(sys.argv[1], 'r') as fi:
        v = fi.readline().strip()
        w = fi.readline().strip()

    s, backtrack = lcs(v, w)

    # for i in s:
    #     print(i)

    # print('-----------------------------')
    # for i in backtrack:
    #     print(i)

    result = []
    outputlcs(backtrack, v, len(v), len(w), result)
    print(''.join(result))


def lcs(v, w):
    s = [[0 for x in range(len(w) + 1)] for x in range(len(v) + 1)]
    backtrack = [[0 for x in range(len(w) + 1)] for x in range(len(v) + 1)]
    for i in range(1, len(v) + 1):
        for j in range(1, len(w) + 1):
            if v[i - 1] == w[j - 1]:
                s_diag = s[i - 1][j - 1] + 1
            else:
                s_diag = s[i - 1][j - 1]
            s[i][j] = max(s[i - 1][j], s[i][j - 1], s_diag)

            if s[i][j] == s[i - 1][j]:
                backtrack[i][j] = 'down'
            elif s[i][j] == s[i][j - 1]:
                backtrack[i][j] = 'right'
            elif s[i][j] == s[i - 1][j - 1] + 1:
                backtrack[i][j] = 'diagonal'

    return s, backtrack


def outputlcs(backtrack, v, i, j, result):
    if i == 0 or j == 0:
        return None
    if 'down' in backtrack[i][j]:
        outputlcs(backtrack, v, i - 1, j, result)
    elif 'right' in backtrack[i][j]:
        outputlcs(backtrack, v, i, j - 1, result)
    else:
        outputlcs(backtrack, v, i - 1, j - 1, result)
        result.append(v[i - 1])


if __name__ == '__main__':
    main()
