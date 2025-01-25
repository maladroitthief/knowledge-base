---
title: Not understanding slice length and capacity
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding slice length and capacity

A slice is an array that can grow or shrink in size. In Go, a slice is backed by
an array, and handles the logic of adding new elements if the backing array is
full or shrinking it if it is almost empty.

Internally, a slice holds a pointer to the backing array and keeps track of a
length and capacity. The length is the number of elements the slice contains,
while the capacity is the number of elements in the backing array.

## Mistake

When slicing an existing slice, both slice pointers will be referencing the same
array. This can cause unexpected behavior if one of the slices alters its data,
that alteration will also be reflected in the other slice.

## Fix

Initialize a separate slice and populate it using append.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
