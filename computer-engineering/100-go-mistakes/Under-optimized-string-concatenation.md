---
title: Under-optimized string concatenation
layout: idea
tags:
  - 100-go-mistakes
---

# Under-optimized string concatenation



## Mistake

This allocates a new string for each loop. This is due to a string being
immutable in Go.

```go
func concat(values []string) string {
  s := ""
  for _, value := range values {
    s += value
  }
  return s
}
```

## Fix

```go
func concat(values []string) string {
	total := 0
	// Get total number of bytes
	for i := 0; i < len(values); i++ {
		total += len(values[i])
	}

	sb := strings.Builder{}
	sb.Grow(total)
	for _, value := range values {
		_, _ = sb.WriteString(value)
	}

	return sb.String()
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
