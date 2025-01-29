---
title: Mixing up concurrency and parallelism
layout: idea
tags:
  - 100-go-mistakes
---

# Mixing up concurrency and parallelism

## Mistake

Assuming the two are synonymous.

## Fix

Parallelism is every part of a system being independent. Concurrency provides
a structure to solve a problem with parts that may be parallelized.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
