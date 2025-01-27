---
title: Ignoring when to wrap an error
layout: idea
tags:
  - 100-go-mistakes
---

# Ignoring when to wrap an error

## Mistake

Returning errors without context.

## Fix

Wrap errors and provide context

```go
if err != nil {
  return fmt.Errorf("bar failed: %w", err)
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
