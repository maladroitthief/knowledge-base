---
title: Not being aware of data alignment
layout: idea
tags:
  - 100-go-mistakes
---

# Not being aware of data alignment

Data alignment is the concept of having a variable's memory address be a
multiple of its size.

- byte, uint8, int8: 1 byte
- uint16, int16: 2 bytes
- uint32, int32, float32: 4 bytes
- uint64, int64, float64: 8 bytes
- complex128: 16 bytes

For all of these examples, their memory address is guaranteed to be some
multiple of their size. An int32 should have an address that is a multiple of 4.

## Mistake

Since `b1` is a byte and `i` is an int64, there is no way to align `i` with
`b1`, so we must pad the struct with 7 bytes of data to meet the alignment of
`i`. This means we are using 24 bytes of memory to store 10 bytes of data.

```go
// alignment of 8 due to i, total size 24 bytes to store 10 bytes of data
type Foo struct {
  b1 byte // alignment 1, 7 bytes padding
  i int64 // alignment 8
  b2 byte // alignment 1, 7 bytes padding
}
```

## Fix

By just rearranging the struct members, we can eliminate 8 bytes of padding by
packing the two byte attributes together.

```go
// alignment 8, 16 bytes to store 10 bytes of data
type Foo struct {
  i int64 // alignment 8
  b1 byte // alignment 1
  b2 byte // alignment 1, 6 bytes padding
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
