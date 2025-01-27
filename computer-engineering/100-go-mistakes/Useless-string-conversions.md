---
title: Useless string conversions
layout: idea
tags:
  - 100-go-mistakes
---

# Useless string conversions

## Mistake

Converting strings to []byte slice when it doesn't make sense. While strings are
human friendly, []byte slices is what most functions accept as a parameter.

## Fix

Use []byte slice and the relevant transforms in the `bytes` package.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
