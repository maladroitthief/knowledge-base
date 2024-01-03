---
tags:
  - idea
aliases:
---

# Interval

An interval is a subset of an array where the array consists of two element arrays. The two elements represent a start and end value.

```go
interval := [][2]int{}
```

It is important when considering intervals to figure out if they should be inclusive or exclusive when it comes to overlapping and if the starting value will always be smaller than the ending value.

## Corner cases

- No intervals
- Single interval
- Two intervals
- Non-overlapping intervals
- Interval that completely overlaps another interval
- Duplicates
- Intervals that start where other intervals end

## Techniques

### Sort the array by starting point

This is a crucial strategy when handling interval merging

### Checking if two intervals overlap

```go
func overlap(a, b [2]int) bool {
	return a[0] < b[1] && b[0] < a[1]
}
```

### Merging intervals

```go
func mergeOverlappingIntervals(a, b [2]float64) [2]float64 {
	return [2]float64{ math.Min(a[0], b[0]), math.Max(a[1], b[1])
}
```

## References

- [Array](Array.md)
- [Tech-Interview-Handbook](Tech-Interview-Handbook.md)
