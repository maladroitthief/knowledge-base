---
title: Being confused about when to use generics
layout: idea
tags:
  - 100-go-mistakes
---

# Being confused about when to use generics

Generics in Go are types that can be specified later. Before generics were added
to Go, handling similar functionality across types was a chore. With generics we
can leverage the following builtin type constraints:

- any
- comparable

Or we can define a custom constraint:

```go
type customConstraint interface {
  ~int | ~string // this constraint only supports ints and strings
}
```

> `int` is a restriction to specifically an int while `~int` supports all values
> whose underlying type is int

## Mistake

Using generics when it offers no value or when it makes the code too complicated

## Fix

Only consider using generics for the following cases:

- Data structures
- Functions operating on slices, maps, or channels

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
