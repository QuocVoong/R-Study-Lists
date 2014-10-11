#!/usr/bin/env python

import sys


def better_bwmatching(bwt, seqs):
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

    count = {
        'A': {0: 0},
        'T': {0: 0},
        'C': {0: 0},
        'G': {0: 0},
        '$': {0: 0},
    }
    for i, j in enumerate(lstcol):
        j = remove_digit(j)
        count.get('A')[i + 1] = count.get('A')[i]
        count.get('T')[i + 1] = count.get('T')[i]
        count.get('C')[i + 1] = count.get('C')[i]
        count.get('G')[i + 1] = count.get('G')[i]
        count.get('$')[i + 1] = count.get('$')[i]
        count.get(j)[i + 1] += 1

    first_occurrence = {}
    for i, j in enumerate(fstcol):
        j = remove_digit(j)
        if j not in first_occurrence:
            first_occurrence.update({j: i})

    indices = []
    for seq in seqs:
        pattern = list(seq)
        top = 0
        bottom = len(lstcol) - 1
        while top <= bottom:
            if pattern:
                symbol = pattern.pop()
                contain_occurrence = False
                for i in range(top, bottom + 1):
                    if symbol == remove_digit(lstcol[i]):
                        contain_occurrence = True
                        break
                if contain_occurrence:
                    top = first_occurrence.get(symbol) + count.get(symbol)[top]
                    bottom = first_occurrence.get(symbol) + count.get(symbol)[bottom + 1] - 1
                else:
                    indices.append(0)
                    break
            else:
                indices.append(bottom - top + 1)
                break

    return indices


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

    indices = better_bwmatching(bwt, seqs)

    print(' '.join([str(x) for x in indices]))


if __name__ == '__main__':
    main()
