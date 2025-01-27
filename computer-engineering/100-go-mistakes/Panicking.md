---
title: Panicking
layout: idea
tags:
  - 100-go-mistakes
---

# Panicking

Once a panic is triggered, it continues up the call stack until either the
current goroutine has returned or panic is caught with recover.

## Mistake

Panicking any time an error occurs is a mistake.

## Fix

Only panic when a programming error has occurred to signal that this mistake is
a bug and not a runtime error.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
