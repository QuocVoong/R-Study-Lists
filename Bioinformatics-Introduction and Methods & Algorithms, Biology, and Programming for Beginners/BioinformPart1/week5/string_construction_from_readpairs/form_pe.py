#!/usr/bin/env python
# https://beta.stepic.org/Bioinformatics-Algorithms-2/Assembling-Read-Pairs-204/#step-6

STR = 'TAATGCCATGGGATGTT'
K = 3
D = 2


def main():
    string = STR
    k = K
    d = D

    kmers = []
    for i in range(len(string) - (2 * k + d) + 1):
        r1 = string[i: i + k]
        r2 = string[i + k + d:i + 2 * k + d]
        kmers.append('{0}|{1}'.format(r1, r2))

    kmers.sort()
    print(' '.join(kmers))


if __name__ == '__main__':
    main()
