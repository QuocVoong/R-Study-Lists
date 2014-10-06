#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        p = [int(x) for x in fi.readline().strip('\n()').split(' ')]

    greedy_sorting(p)


def greedy_sorting(p):
    approx_reversal_distance = 0
    for k in range(1, len(p) + 1):
        if not is_sorted(p, k):
            p = k_sorting_reversal(p, k)
            print('({0})'.format(' '.join(['{0:+d}'.format(x) for x in p])))
            approx_reversal_distance += 1
        if p[k - 1] < 0:
            p[k - 1] = -p[k - 1]
            print('({0})'.format(' '.join(['{0:+d}'.format(x) for x in p])))
            approx_reversal_distance += 1

    return approx_reversal_distance


def is_sorted(p, k):
    if abs(p[k - 1]) == k:
        return True
    else:
        return False


def k_sorting_reversal(p, k):
    for i, j in enumerate(p):
        if abs(j) == k:
            pos_k = i + 1
            break

    p1 = p[k - 1:pos_k]
    sr_p = p[0:k - 1] + [-x for x in p1[::-1]] + p[pos_k:]

    return sr_p


if __name__ == '__main__':
    main()
