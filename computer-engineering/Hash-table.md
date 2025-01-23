---
title: Hash table
layout: idea
tags:
  - data-structures
---

# Hash table

A hash table is a data structure that can map keys to values using a hash
function. It does this by computing an index using the hash function and stores
the value in an array.

| Operation | Big-O |
| --------- | ----- |
| Access    | N/A   |
| Search    | O(1)  |
| Insert    | O(1)  |
| Remove    | O(1)  |

To be clear, the `O(1)` is average case as it depends on the underlying hash
function, but in most instances it is safe to assume average case.

## References

- [Tech-Interview-Handbook](/reference/Tech-Interview-Handbook)
