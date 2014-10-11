#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        spectrum = sorted([int(i) for i in fi.readline().strip().split(' ')])

    elements = []
    for i in spectrum:
        for j in spectrum:
            if i == j:
                break
            elements.append(abs(i - j))

    print(' '.join([str(i) for i in elements]))


if __name__ == '__main__':
    main()
