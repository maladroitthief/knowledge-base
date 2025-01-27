---
title: Comparing values incorrectly
layout: idea
tags:
  - 100-go-mistakes
---

# Comparing values incorrectly

Comparing values in Go, using `==` is not always appropriate.

## Mistake

`==` and `!=` do not work with slices and maps.

## Fix

Consider using `reflect.DeepEqual()`, but keep in mind this is significantly
slower than `==`. If performance is critical, instead compare each element of
the slice/map through iteration.

For testing solutions, consider external packages like `go-cmp` or `testify`.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
