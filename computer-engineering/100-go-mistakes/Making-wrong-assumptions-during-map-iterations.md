---
title: Making wrong assumptions during map iterations
layout: idea
tags:
  - 100-go-mistakes
---

# Making wrong assumptions during map iterations

There are two primary misconceptions with map iterations in Go.

## Mistake

### Ordering

Order is not preserved in a map in Go. Iterating over a map multiple times will
likely result in a unique ordering for each iteration.

### Map insert during iteration

Updating a map's contents during iteration is allowed, but can lead to
unpredictable results. When a map entry is created during iteration, it may be
produced during the iteration or skipped.

```go
m := map[int]bool{
	0: true,
	1: false,
	2: true,
}

// The contents of this map cannot be predicted
for k, v := range m {
	if v {
		m[10+k] = true
	}
}
```

## Fix

Create a copy of the map to modify instead of the map that is being iterated.

```go
m := map[int]bool{
	0: true,
	1: false,
	2: true,
}

m2 := copyMap(m)

for k, v := range m {
	if v {
		m2[10+k] = true
	}
}
```



## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
