---
title: Inefficient slice initialization
layout: idea
tags:
  - 100-go-mistakes
---

# Inefficient slice initialization

When initializing a slice using `make` we can provide a length and an optional
capacity.

## Mistake

Not giving a slice enough capacity when we know it will grow in size. In Go,
a slice is resized by doubling it's capacity and allocating a new backing array.

## Fix

If we know a slice will grow substantially, we should give it enough capacity to
minimize the number of allocations it will require.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
