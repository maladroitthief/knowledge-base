---
title: Creating utility packages
layout: idea
tags:
  - 100-go-mistakes
---

# Creating utility packages

## Mistake

Creating any package named `utils`, `common`, or `base` is almost always
a mistake. They become junk drawers for unrelated functions and provide no
insight to what they provide.

## Fix

Use specific names when naming packages and, if necessary, break up utility
packages into smaller meaningful pieces.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
