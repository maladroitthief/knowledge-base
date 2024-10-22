---
title: Binary search tree
layout: idea
tags:
  - data-structures
---

# Binary-search-tree

A binary-search tree (BST) is a [Binary-tree](/computer-engineering/Binary-tree) that
gives all the elements in order when it is traversed in order. In-order
traversal being:

> Left -> Root -> Right

BSTs are useful because of their time complexity.

| Operation | Big-O     |
| --------- | --------- |
| Access    | O(log(n)) |
| Search    | O(log(n)) |
| Insert    | O(log(n)) |
| Remove    | O(log(n)) |

The space complexity of traversing balanced trees is O(h) where h is the height
of the tree.

## References

- [Tech-Interview-Handbook](/reference/Tech-Interview-Handbook)
