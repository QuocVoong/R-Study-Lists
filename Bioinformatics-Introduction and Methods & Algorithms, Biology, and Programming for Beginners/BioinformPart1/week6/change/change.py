#!/usr/bin/env python

import sys


def main():
    with open(sys.argv[1], 'r') as fi:
        money = int(fi.readline())
        coins = [int(x) for x in fi.readline().split(',')]

    min_num_coins = dpchange(money, coins)
    print(min_num_coins)


def dpchange(money, coins):
    min_num_coins = {}
    min_num_coins.update({0: 0})
    for i in range(1, money + 1):
        min_num_coins.update({i: i})
        for j in coins:
            if i >= j:
                if min_num_coins.get(i - j) + 1 < min_num_coins.get(i):
                    min_num_coins[i] = min_num_coins.get(i - j) + 1

    return min_num_coins.get(money)


if __name__ == '__main__':
    main()
