#!/usr/bin/env python
# TODO

import sys
import re


class PatternTree(object):

    class _Node(object):

        def __init__(self, pattern):
            self.pattern = pattern
            self.size = len(pattern)
            self.re = re.compile(pattern.replace('n', '[atcg]'), re.IGNORECASE)
            self._database = super(PatternTree, self)._Database()

        def add(self, sequences):
            self._database.add(sequences)

    class _Database(object):

        def __init__(self):
            self._index = 1
            self._size = 0
            self.data = {}

        def add(self, sequences):
            for i in sequences:
                self.data.update({self._index: i})
                self._size += 1
            self._index += 1

    class Position(object):

        def __init__(self, container, node):
            self._container = container
            self._node = node

        def element(self):
            return self._node._element

        def __eq__(self, other):
            return type(other) is type(self) and other._node is self._node

    def _validate(self, p):
        assert isinstance(p, self.Position)
        assert p._container is self
        assert p._node._parent is not p._node
        return p._node

    def _make_position(self, node):
        if node:
            return self.Position(self, node)
        else:
            return None

    def __init__(self):
        self._root = None
        self._size = 0

    def __len__(self):
        return self._size

    def root(self):
        return self._root

    def parent(self, p):
        node = self._validate(p)
        return self._make_position(node._parent)

    # def childs(self, p):
    #     node = self._validate(p)
    #     return self._make_position(node._childs)


def main():
    with open(sys.argv[1], 'r') as fi:
        seq, k, d = fi.readline().strip().split(' ')

    k = int(k)
    d = int(d)

    tree = PatternTree(d)
