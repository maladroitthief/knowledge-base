---
title: Not properly checking if a slice is empty
layout: idea
tags:
  - 100-go-mistakes
---

# Not properly checking if a slice is empty

What is the clear and concise method for checking if a slice has any elements?

## Mistake

This handles the nil slice, but does not work for a slice with zero elements

```go
if slice == nil {
  return
}
```

## Fix

```go
if len(slice) == 0 {
  return
}
```


## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
