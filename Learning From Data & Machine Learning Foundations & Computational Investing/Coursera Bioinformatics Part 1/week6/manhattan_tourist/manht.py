#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        n = int(fi.readline())
        m = int(fi.readline())
        down = []
        for i in range(n):
            line = fi.readline()
            down.append([int(x) for x in line.split(' ')])
        fi.readline()
        right = []
        for i in range(n + 1):
            line = fi.readline()
            right.append([int(x) for x in line.split(' ')])

    len_logest_path = manhattan_tourist(n, m, down, right)
    print(len_logest_path)


def manhattan_tourist(n, m, down, right):
    s = [[0 for x in range(m + 1)] for x in range(n + 1)]
    s[0][0] = 0

    for i in range(1, n + 1):
        s[i][0] = s[i - 1][0] + down[i - 1][0]

    for j in range(1, m + 1):
        s[0][j] = s[0][j - 1] + right[0][j - 1]

    for i in range(1, n + 1):
        for j in range(1, m + 1):
            s[i][j] = max(s[i - 1][j] + down[i - 1][j], s[i][j - 1] + right[i][j - 1])

    return s[n][m]


if __name__ == '__main__':
    main()
