#!/usr/bin/python
# -*- coding: utf-8 -*-

bag = [0b010101, 0b101010, 0b111000,0b000111]

success = 0
total = 0
#暴力枚举5^4种情况
def dfs(cur = 0b111111,times=5):
    if times == 0:
        global success
        global total
        total += 1
        success += cur!=0
    else:
        for sample in bag:
            dfs(cur & sample,times-1)

dfs()
prob = 1.0 * success / total

print prob,success,'/',total

