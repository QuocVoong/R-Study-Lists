#!/usr/bin/env python

import sys


def bwt(seq):
    sorted_seqs = sorted(list(generate_rotated_sequences(seq)))
    return ''.join([x[len(seq) - 1] for x in sorted_seqs])


def generate_rotated_sequences(seq):
    double_seq = seq * 2
    for i in range(len(seq)):
        yield double_seq[i: i + len(seq)]


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
        'P': {0: 0},
        'N': {0: 0},
        'M': {0: 0},
        'B': {0: 0},
        'S': {0: 0},

    }
    for i, j in enumerate(lstcol):
        j = remove_digit(j)
        count.get('A')[i + 1] = count.get('A')[i]
        count.get('T')[i + 1] = count.get('T')[i]
        count.get('C')[i + 1] = count.get('C')[i]
        count.get('G')[i + 1] = count.get('G')[i]
        count.get('$')[i + 1] = count.get('$')[i]
        count.get('P')[i + 1] = count.get('P')[i]
        count.get('N')[i + 1] = count.get('N')[i]
        count.get('M')[i + 1] = count.get('M')[i]
        count.get('B')[i + 1] = count.get('B')[i]
        count.get('S')[i + 1] = count.get('S')[i]
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
                    indices.append(None)
                    break
            else:
                assert bottom == top
                indices.append(top)
                break

    return indices


def remove_digit(s):
    output = []
    for i in s:
        if not i.isdigit():
            output.append(i)

    return ''.join(output)


def partial_sarray(seq, k):
    bwt_seq = bwt(seq)
    partial_suffix_seqs = {}
    partial_suffix_seqs_keys = []
    for i in range(0, len(seq), k):
        partial_suffix_seqs.update({seq[i:]: i})
        partial_suffix_seqs_keys.append(seq[i:])

    indices = better_bwmatching(bwt_seq, partial_suffix_seqs_keys)

    partial_suffix_array = []
    for i, j in enumerate(partial_suffix_seqs_keys):
        partial_suffix_array.append((indices[i], partial_suffix_seqs.get(j)))

    return partial_suffix_array


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        k = int(fi.readline())

    suffix_arrary = partial_sarray(seq, k)
    # suffix_arrary = sorted(suffix_arrary, key=lambda x: x)
    for i, j in suffix_arrary:
        print(','.join([str(i), str(j)]))


if __name__ == '__main__':
    main()
