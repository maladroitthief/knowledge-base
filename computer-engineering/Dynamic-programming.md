---
title: Dynamic programming
layout: idea
tags:
  - computer-engineering
---

# Dynamic programming

Dynamic programming is a technique for efficiently implementing a recursive
algorithm by storing partial results. This is helpful because it allows for an
exhaustive search without processing the same partial result over and over. It
is important to know that this is a trade off of time complexity for space.

## Examples

### go

#### Before

```go
func fib(n int) int{
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}
	return fib(n-2) + fib(n-1)
}
```

#### After

```go
const (
	miss = -1
	maxN = 92
)

var(
	cache = make([]int, maxN)
)

func fibDriver(n int) int{
	for i := range cache {
		cache[i] = miss
	}
	cache[0] = 0
	cache[1] = 1
	return fib(n)
}

func fib(n int){
	if cache[n] == miss {
		cache[n] = fib(n-2) + fib(n-1)
	}
	return cache[n]
}
```

## References

- [Tech-Interview-Handbook](/reference/Tech-Interview-Handbook)
- [The-Algorithm-Design-Manual](/reference/The-Algorithm-Design-Manual)
