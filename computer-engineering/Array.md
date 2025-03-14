---
title: Array
layout: idea
tags:
  - data-structures
---

# Array

An array is a collection of items that are held in order at a specific index.
They are useful for storing objects of the same type in a single variable and it
is very quick to access elements if you have the index. It should also be said
that adding or removing objects to the middle of an array can be a slow process.

| Operation              | Big-O     | Note                                       |
| ---------------------- | --------- | ------------------------------------------ |
| Access                 | O(1)      |                                            |
| Search                 | O(n)      |                                            |
| Search (sorted)        | O(log(n)) |                                            |
| Insert/Remove          | O(n)      | requires shifting elements by 1            |
| Insert/Remove (at end) | O(1)      | special case where no shifting is required |

## Common edge cases

- Empty sequence
- Sequence with 1 or 2 elements
- Sequence with repeated elements
- Duplicate values in sequence

## Techniques

- [Sliding window](/computer-engineering/Sliding-window)
- [Two pointers](/computer-engineering/Two-pointers)
- [Traverse from right](/computer-engineering/Traverse-from-right)
- [Sorting-and-searching](/computer-engineering/Sorting-and-searching)
- [Pre-computation](/computer-engineering/Pre-computation)
- [Index as hash key](/computer-engineering/Index-as-hash-key)
- [Traversing multiple times](/computer-engineering/Traverse-from-right)
