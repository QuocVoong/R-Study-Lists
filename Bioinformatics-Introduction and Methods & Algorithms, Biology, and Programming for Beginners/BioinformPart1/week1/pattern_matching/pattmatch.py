#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        pattern = fi.readline().strip()
        sequence = fi.readline().strip()

    match = []
    for i in range(len(sequence) - len(pattern)):
        if sequence[i: i + len(pattern)] == pattern:
            match.append(str(i))

    print(' '.join(match))


if __name__ == '__main__':
    main()
