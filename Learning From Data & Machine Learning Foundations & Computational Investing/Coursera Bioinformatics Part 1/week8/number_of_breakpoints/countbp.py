#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        p = [int(x) for x in fi.readline().strip('\n()').split(' ')]

    nbreakpoints = countbp(p)
    print(nbreakpoints)


def countbp(p):
    p = [0] + p + [len(p) + 1]
    first = 0
    nbreakpoints = 0
    for i in p[1:]:
        if not is_inorder(first, i):
            nbreakpoints += 1
        first = i

    return nbreakpoints


def is_inorder(m, n):
    if m >= 0 and n >= 0 and n == m + 1:
        return True
    elif m < 0 and n < 0 and n == m + 1:
        return True
    else:
        return False


if __name__ == '__main__':
    main()
