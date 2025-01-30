---
title: time.After and memory leaks
layout: idea
tags:
  - 100-go-mistakes
---

# time.After and memory leaks

`time.After(time.Duration)` is the concurrent alternative for
`time.Sleep(time.duration)`.

## Mistake

This would result in creating a new time.After instance that is not release
until the timer expires for every iteration of this loop/every message received.

```go
func consumer(ch <-chan Event) {
  for {
    select {
    case event := <-ch:
      // ...
    case <-time.After(time.Hour):
      // ...
    }
  }
}
```

## Fix

This is better, but creating a new context every loop is still not great.

```go
func consumer(ch <-chan Event) {
  for {
    ctx, cancel := context.WithTimeout(context.Background(), time.Hour)
    select {
      case event := <-ch:
        cancel()
        // ...
      case <-ctx.Done():
        // ...
    }
  }
}
```

The more appropriate approach would be to use a timer.

```go
func consumer(ch <-chan Event) {
  timerDuration := 1 * time.Hour
  timer := time.NewTimer(timerDuration)
  for {
    timer.Reset(timerDuration)
    select {
    case event := <-ch:
      // ...
    case <-timer.C:
      // ...
    }
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
