---
title: Substrings and memory leaks
layout: idea
tags:
  - 100-go-mistakes
---

# Substrings and memory leaks

## Mistake

```go
uuid := log[:36] // slices the string, but keeps the backing array
```

## Fix

```go
uuid := string([]byte(log[:36])) // copies the sub-string into a []byte
uuid := strings.Clone(log[:36]) // creates a new copy of the string
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
