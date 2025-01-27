---
title: Never using named result parameters
layout: idea
tags:
  - 100-go-mistakes
---

# Never using named result parameters

## Mistake

Name result parameters should be used when would provide better context.

```go
type locator interface {
  getCoordinates(address string) (float32, float32, error)
}
```

Name result parameters should not be used when they provide no value

```go
func ReadFull(r io.Reader, buf []byte) (n int, err error) {
  // ...
}
```

## Fix

```go
type locator interface {
  getCoordinates(address string) (lng, lat float32, error)
}
```

```go
func ReadFull(r io.Reader, buf []byte) (int, error) {
  // ...
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
