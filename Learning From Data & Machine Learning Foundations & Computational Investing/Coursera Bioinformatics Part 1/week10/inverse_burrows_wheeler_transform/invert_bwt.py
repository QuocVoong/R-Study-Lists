#!/usr/bin/env python

import sys


def invert_bwt(seq):
    lstcol = []
    ai = 1
    ti = 1
    ci = 1
    gi = 1
    for i in seq:
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
    for i in sorted(seq):
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
    output = [fstcol[0]]

    index = lstcol.index('$')
    for i in range(len(seq) - 2):
        output.append(remove_digit(fstcol[index]))
        index = lstcol.index(fstcol[index], 1)
        lstcol[index] = None
    output.append(remove_digit(fstcol[index]))
    output.append('$')

    return ''.join(output[1:])


def remove_digit(s):
    output = []
    for i in s:
        if not i.isdigit():
            output.append(i)

    return ''.join(output)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()

    result = invert_bwt(seq)
    print(result)


if __name__ == '__main__':
    main()
