---
title: Maps and memory leaks
layout: idea
tags:
  - 100-go-mistakes
---

# Maps and memory leaks

When maps grow and shrink, buckets need to be added to the underlying data
structure to support it.

## Mistake

When shrinking a map, the elements will be garbage collected, however the
buckets will still remain.

## Fix

Either create a new map and copy all the elements of the old map to it. This
would result in a brief window of high memory consumption considering the two
maps, but the old map would be eventually collected. Alternatively, make the
values pointers. Pointers take up less memory and even though the buckets will
still remain, there should be significantly less of them.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
