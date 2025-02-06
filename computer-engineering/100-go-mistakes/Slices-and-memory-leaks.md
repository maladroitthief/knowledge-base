---
title: Slices and memory leaks
layout: idea
tags:
  - 100-go-mistakes
---

# Slices and memory leaks

Slicing an existing slice can lead to memory leaks under certain conditions.

## Leaking capacity

### Mistake

```go
func getMessageType(msg []byte) []byte {
  return msg[:5] // This makes a slice with the same capacity as msg
}
```

### Fix

```go
func getMessageType(msg []byte) []byte {
  msgType := make([]byte, 5)
  copy(msgType, msg)
  return msgType
}
```

## Slices and pointers

When working with slices, if the element is a pointer or a struct with pointer
fields, it will not be collected by the garbage collector.

Either make a copy of the slice to remove unwanted elements or set the remaining
slices to nil.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
