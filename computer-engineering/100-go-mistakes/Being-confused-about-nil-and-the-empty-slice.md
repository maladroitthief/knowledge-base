---
title: Being confused about nil and the empty slice
layout: idea
tags:
  - 100-go-mistakes
---

# Being confused about nil and the empty slice

A slice is empty if it's length is zero. A slice is nil if it is nil.

## Mistake

Not being educated on the differences between the two.

## Fix

A nil slice requires no allocation and because of this we should favor returning
nil slices as a result

```go
// if we don't know the length and the slice can be empty
var s []string
// another way to create a nil and empty slice that can be helpful
s := append([]int(nil), 42)
// If we know the future length
make([]string, length)
// Avoid this style unless we are initializing with elements
s := []string{}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
