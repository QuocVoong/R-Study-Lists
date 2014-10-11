#!/usr/bin/env python

import sys


def generate_seeds(seq, d):
    k = len(seq) // (d + 1)
    seeds = {}
    c = 0
    for i in range(0, len(seq), k):
        c += 1
        if c <= d:
            seeds.update({i: seq[i: i + k]})
        else:
            seeds.update({i: seq[i:]})
            break

    return seeds


def match(seq_1, seq_2, d):
    m = 0
    for i, j in zip(seq_1, seq_2):
        if i != j:
            m += 1
            if m > d:
                return False

    return True


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        patterns = fi.readline().strip().split(' ')
        d = int(fi.readline())

    starts = {}
    s = 0
    for pattern in patterns:
        starts.update({s: set()})
        seeds = generate_seeds(pattern, d)
        for p_start, seed in seeds.items():
            start = 0
            while 1:
                m_start = seq.find(seed, start)
                if m_start == -1:
                    break
                extended = seq[m_start - p_start: m_start + len(pattern) - p_start]
                if match(extended, pattern, d):
                    starts.get(s).add(m_start - p_start)
                start = m_start + 1

        s += 1

    starts_array = []
    for i in starts.values():
        starts_array += list(i)
    print(' '.join([str(x) for x in sorted(starts_array)]))


if __name__ == '__main__':
    main()
