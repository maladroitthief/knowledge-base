---
title: Creating confusion with octal literals
layout: idea
tags:
  - 100-go-mistakes
---

# Creating confusion with octal literals

Any integer literal in Go that begins with a `0` is considered to be an octal

## Mistake

```go
// This equals 108, not 110
sum := 100 + 010
```

## Fix

Use the long form prefix `0o` for describing octals

```go
sum := 100 + 0o10
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
