---
title: Unexpected side effects of using slice append
layout: idea
tags:
  - 100-go-mistakes
---

# Unexpected side effects of using slice append

When slicing another slice, the newly created slice will have a pointer
referencing the backing array of the original slice. This means that any
modifications to either slice will be reflected in both.

## Mistake

When appending contents to either slice that will not fit inside the backing
array, a new backing array must be created. This breaks the relationship between
the two slices.

## Fix

Create a copy of the original slice to avoid this behavior.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
