#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    length = len(seq) + 1
    skew = [0] * length
    start = 0
    for i, j in enumerate(seq):
        if j == 'C':
            start -= 1
        elif j == 'G':
            start += 1

        skew[i + 1] = start

    lowest = skew[0]
    lowest_index = []
    for i, j in enumerate(skew):
        if j < lowest:
            lowest = j
            lowest_index = [i]
        elif j == lowest:
            lowest_index.append(i)

    lowest_index = [str(i) for i in lowest_index]
    print(' '.join(lowest_index))


if __name__ == '__main__':
    main()
