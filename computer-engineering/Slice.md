---
title: Slice
layout: idea
tags:
  - data-structures
---

# Slice

A slice is an array that can grow or shrink in size. In Go, a slice is backed by
an array, and handles the logic of adding new elements if the backing array is
full or shrinking it if it is almost empty.

Internally, a slice holds a pointer to the backing array and keeps track of a
length and capacity. The length is the number of elements the slice contains,
while the capacity is the number of elements in the backing array.

```go
// creating a slice of length 3 and capacity 6
s := make([]int, 3, 6)
```

When adding more elements to the slice that the backing array cannot hold, Go
will double the capacity of the backing array, copy all elements to it, and then
insert the new elements.

## Slicing

Slicing is an operation done on either a slice or an array where only part of
it's capacity is exposed.

```go
// creating a slice of length 3 and capacity 6
s := make([]int, 3, 6)
// slicing the first slice to a new slice
// length 2, capacity 5
t := s[1:3]
```

It is important to keep in mind that both slices represent the same backing
array so any modifications will impact both. Changing a value in `t[0]` would
also change `s[1]` due to the index being offset in the second slice. However,
causing either slice to grow and double the backing array will result in two
separate backing arrays.

## Efficiency

When working with slices that will be known to grow significantly in size, it is
recommended to make use of the optional capacity field in `make`. Each time a
slice grows larger than the backing array, the backing array needs to double and
the values must be copied to the new slice. This can create unnecessary work for
the garbage collector.

```go
// create an empty slice, but set the backing array to an initial size of 512
s := make([]int, 0, 512)
```

## References

- [100-go-mistakes-and-how-to-avoid-them](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
