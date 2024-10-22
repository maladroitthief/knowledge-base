---
title: Sliding window
layout: idea
tags:
  - algorithms
---

# Sliding window

Sliding window is a technique that accomplishes what would normally taking
multiple iterations in a single iteration. The technique can be applied when
given a window of a known size, finding the result for the first window, and
then shifting the window to the next position in the array or string.

## Common use cases

- largest sum
- min/max sum
- sub array/string

## Examples

### python

```python
def slidingWindow(arr, windowSize):
	arrLen = len(arr)
	# outer loop needs to account for to avoid out of bounds
	for i in range(arrLen - windowSize + 1):
		# inner loop only needs to iterate over the window
		for j in range(windowSize)
			# operation inside the window
	return result
```

### go

```go
func slidingWindow(arr []int, windowSize int) int {
	arrLen := len(arr)
	// outer loop needs to account for to avoid out of bounds
	for i := 0; i < (arrLen - windowSize + 1); i++{
		// inner loop only needs to iterate over the window
		for j := 0; j < windowSize; j++ {
			// operation inside the window
		}
	}
	return result
}
```

