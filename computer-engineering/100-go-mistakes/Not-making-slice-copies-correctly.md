---
title: Not making slice copies correctly
layout: idea
tags:
  - 100-go-mistakes
---

# Not making slice copies correctly

The builtin `copy` function allows copying elements from one slice to another.

## Mistake

The number of elements copied to the destination slice corresponds to the
minimum value between the source slice length and the destination slice length.
If the destination slice is an empty slice, then 0 elements will be copied.

## Fix

Use a destination slice with a length equal to or greater than the source slice

```go
src := []int{0, 1, 2}
dest := make([]int, len(src))
copy(dest, src)
```

The alternative append form which is more concise, but less obvious

```go
src := []int{0, 1, 2}
dest := append([]int(nil), src...)
```


## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
