---
title: Providing a wrong time duration
layout: idea
tags:
  - 100-go-mistakes
---

# Providing a wrong time duration

## Mistake

It is not obvious when this ticker will go off. We would assume every second,
but in fact it is ever microsecond.

```go
ticker := time.NewTicker(1000)
for {
  select {
  case <-ticker.C:
    // tick
  }
}

```

## Fix

Using the time durations provided from the `time` package we can be certain how
this ticker works.

```go
ticker := time.NewTicker(time.Second)
for {
  select {
  case <-ticker.C:
    // tock
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
