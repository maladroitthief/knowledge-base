---
title: Unintended side effects with named result parameters
layout: idea
tags:
  - 100-go-mistakes
---

# Unintended side effects with named result parameters

## Mistake

Under normal circumstances, this code would not compile because we never set nor
initialize the `err` variable. However, since it is a named result parameter the
err variable is initialized to it's zero value and as a result `err` always
returns nil.

```go
func (l loc) getCoordinates(ctx context.Context, address string) (lat, lng float32, err error) {
  isValid := l.validateAddress(address)

  if !isValid {
    return 0, 0, errors.New("invalid address")
  }

  if ctx.Err() != nil {
    return 0, 0, err
  }
}
```

## Fix

Either avoid named result parameters or shadow the `err` variable.

```go
func (l loc) getCoordinates(ctx context.Context, address string) (lat, lng float32, err error) {
  isValid := l.validateAddress(address)

  if !isValid {
    return 0, 0, errors.New("invalid address")
  }

  err := ctx.Err()
  if err != nil {
    return 0, 0, err
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
