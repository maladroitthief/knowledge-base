---
title: Creating data races with append
layout: idea
tags:
  - 100-go-mistakes
---

# Creating data races with append

## Mistake

This is a data race because the array is not full. Both goroutines will attempt
to update the same index in the backing array.

```go
s := make([]int, 0, 1)

go func() {
  s1 := append(s, 1)
}()

go func() {
  s2 := append(s, 1)
}()
```

## Fix

Instead we can copy the slice and append to that.

```go
s := make([]int, 0, 1)

go func() {
  sCopy := make([]int, len(s), cap(s))
  copy(sCopy, s)

  s1 := append(sCopy, 1)
}()

go func() {
  sCopy := make([]int, len(s), cap(s))
  copy(sCopy, s)

  s2 := append(sCopy, 1)
}()
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
