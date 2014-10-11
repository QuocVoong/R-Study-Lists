#!/usr/bin/env python

import sys


def suffix_array_to_suffix_tree(seq, suffix_array, lcp):
    edge_labels = []

    for i, j in enumerate(lcp):
        if j == 0:
            if i < len(lcp) - 1:
                if lcp[i + 1] > j and seq[suffix_array[i]: suffix_array[i] + lcp[i]] in seq[suffix_array[i + 1]: suffix_array[i + 1] + lcp[i + 1]]:
                    edge_labels.append(seq[suffix_array[i]: suffix_array[i] + lcp[i + 1]])
                    edge_labels.append(seq[suffix_array[i] + lcp[i + 1]:])
                else:
                    edge_labels.append(seq[suffix_array[i]:])
            else:
                edge_labels.append(seq[suffix_array[i]:])
        else:
            if i < len(lcp) - 1:
                if lcp[i + 1] > j and seq[suffix_array[i]: suffix_array[i] + lcp[i]] in seq[suffix_array[i + 1]: suffix_array[i + 1] + lcp[i + 1]]:
                    edge_labels.append(seq[suffix_array[i] + j: suffix_array[i] + lcp[i + 1]])
                    edge_labels.append(seq[suffix_array[i] + lcp[i + 1]:])
                elif lcp[i + 1] == j:
                    edge_labels.append(seq[suffix_array[i] + lcp[i + 1]:])
                else:
                    edge_labels.append(seq[suffix_array[i] + j:])
            else:
                edge_labels.append(seq[suffix_array[i] + j:])

    return edge_labels


def main():
    with open(sys.argv[1], 'r') as fi:
        seq = fi.readline().strip()
        suffix_array = [int(x) for x in fi.readline().strip().split(', ')]
        lcp = [int(x) for x in fi.readline().strip().split(', ')]

    edge_labels = suffix_array_to_suffix_tree(seq, suffix_array, lcp)
    for i in edge_labels:
        print(i)


if __name__ == '__main__':
    main()
