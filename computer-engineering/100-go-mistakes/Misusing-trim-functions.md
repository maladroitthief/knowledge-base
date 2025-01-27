---
title: Misusing trim functions
layout: idea
tags:
  - 100-go-mistakes
---

# Misusing trim functions

## Mistake

TrimRight removes all trailing runes in a given set.

```go
fmt.Println(strings.TrimRight("123oxo", "xo")) // "123"
```

## Fix

TrimSuffix removes a trailing suffix

```go
fmt.Println(strings.TrimRight("123oxo", "xo")) // "123o"
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
