---
title: Thinking concurrency is always faster
layout: idea
tags:
  - 100-go-mistakes
---

# Thinking concurrency is always faster


## Mistake

Assuming that a concurrent solution is always faster than a sequential one. If
the workload we are parallelizing is too small, the overhead of creating and
scheduling goroutines quickly becomes the bottle-neck.

## Fix

Create a hybrid approach that only leverages goroutines when the elements being
processed exceeds some threshold.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
