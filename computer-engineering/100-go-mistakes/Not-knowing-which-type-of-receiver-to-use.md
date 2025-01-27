---
title: Not knowing which type of receiver to use
layout: idea
tags:
  - 100-go-mistakes
---

# Not knowing which type of receiver to use

In Go, you can have either a pointer or a value receiver.

## Mistake

This will not mutate the customer balance.

```go
func (c customer) add(v float64) {
  c.balance += v
}
```

## Fix

```go
func (c *customer) add(v float64) {
  c.balance += v
}
```

Use pointer receivers for mutating an object. Use value receivers to keep an
object immutable.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
