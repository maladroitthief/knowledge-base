---
tags:
  - idea
aliases:
---

# Suffix tree

An implementation of a [Trie](Trie.md) but instead of holding characters on the edges, we instead hold sub-strings of the inserted string going from right to left.

## Construction

A naive approach to construction a suffix tree has a complexity of [O(m^2)](Quadratic-functions.md) where m is the length of the input string. This can be improved to [O(m)](Linear-functions.md) using Ukkonen’s Suffix Tree Construction Algorithm.

## References

- [Data-Structures](Data-Structures.md)
