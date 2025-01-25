---
title: Neglecting integer overflows
layout: idea
tags:
  - 100-go-mistakes
---

# Neglecting integer overflows

An integer overflow occurs when an arithmetic operation creates a value outside
the range that can be represented in bytes. In Go an integer overflow or
underflow is silent at run-time.

## Mistake

```go
var counter int32 = math.MaxInt32
counter++ // results in -2_147_483_648
```

## Fix

```go
func IncInt(counter int) int {
	if counter == math.MaxInt {
		panic("int overflow")
	}
	return counter + 1
}

func AddInt(a, b int) int {
	if a > math.MaxInt-b {
		panic("int overflow")
	}
	return a + b
}

func MultiplyInt(a, b int) int {
	// If one of the operands is equal to 0, it directly returns 0.
	if a == 0 || b == 0 {
		return 0
	}

	result := a * b

	if a == 1 || b == 1 {
		// Checks if one of the return result operands is equal to 1
		return result
	}

	if a == math.MinInt || b == math.MinInt {
		// Checks if one of the operands is equal to math.MinInt
		panic("integer overflow")
	}

	if result/b != a {
		// Checks if the multiplication
		panic("integer overflow")
		// leads to an integer overflow
	}

	return result
}
```



## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
