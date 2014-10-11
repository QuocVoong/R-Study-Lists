#!/usr/bin/env python

import sys


def bwmatching(bwt, seq):
    lstcol = []
    ai = 1
    ti = 1
    ci = 1
    gi = 1
    for i in bwt:
        if i == 'A':
            lstcol.append(i + str(ai))
            ai += 1
        elif i == 'T':
            lstcol.append(i + str(ti))
            ti += 1
        elif i == 'C':
            lstcol.append(i + str(ci))
            ci += 1
        elif i == 'G':
            lstcol.append(i + str(gi))
            gi += 1
        else:
            lstcol.append(i)
    fstcol = []
    ai = 1
    ti = 1
    ci = 1
    gi = 1
    for i in sorted(bwt):
        if i == 'A':
            fstcol.append(i + str(ai))
            ai += 1
        elif i == 'T':
            fstcol.append(i + str(ti))
            ti += 1
        elif i == 'C':
            fstcol.append(i + str(ci))
            ci += 1
        elif i == 'G':
            fstcol.append(i + str(gi))
            gi += 1
        else:
            fstcol.append(i)

    lst_to_fst = []
    for i in lstcol:
        lst_to_fst.append(fstcol.index(i))

    top = 0
    bottom = len(lstcol) - 1
    pattern = list(seq)
    while top <= bottom:
        if pattern:
            symbol = pattern.pop()
            top_index = None
            bottom_index = None
            for i in range(top, bottom + 1):
                if symbol == remove_digit(lstcol[i]):
                    if not top_index:
                        top_index = i
                    bottom_index = i
            if not top_index:
                return 0
            else:
                top = lst_to_fst[top_index]
                bottom = lst_to_fst[bottom_index]
        else:
            return bottom - top + 1


def remove_digit(s):
    output = []
    for i in s:
        if not i.isdigit():
            output.append(i)

    return ''.join(output)


def main():
    with open(sys.argv[1], 'r') as fi:
        bwt = fi.readline().strip()
        seqs = fi.readline().strip().split(' ')

    indices = []
    for i in seqs:
        indices.append(bwmatching(bwt, i))

    print(' '.join([str(x) for x in indices]))


if __name__ == '__main__':
    main()
