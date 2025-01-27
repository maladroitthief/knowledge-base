---
title: Inefficient map initialization
layout: idea
tags:
  - 100-go-mistakes
---

# Inefficient map initialization

In Go a map is an unordered key value pair where all keys are distinct.

```go
m := map[string]int {
  "one": 1,
  "two": 2,
  "three": 3,
}
```

## Mistake

When a map grows, it doubles the number of buckets used to back it. This occurs
when the average number of items in the buckets is greater than a constant value
(6.5) or too many buckets have overflowed. When the map grows, all keys are
dispatched again to all buckets which can become expensive with large maps.

## Fix

Initialize the map with a capacity that is reasonable for what it will be used
for.

```go
m := make(map[string]int, 1_000_000)
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
