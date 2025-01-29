---
title: Misunderstanding Go contexts
layout: idea
tags:
  - 100-go-mistakes
---

# Misunderstanding Go contexts

A Context carries a deadline, a cancellation signal, and other values across API
boundaries.

## Deadline

A deadline is a specific point in time:

- time.Duration
- time.Time

If a deadline is met then any ongoing activities using that context should be
stopped.

```go
func (h publishHandler) publishPosition(position flight.Position) error {
  // context with a deadline of 4 seconds
  ctx, cancel := context.WithTimeout(context.Background(), 4*time.Second)
  defer cancel() // safeguard to cancel the context goroutine

  return h.pub.Publish(ctx, position)
}
```

## Cancellation signals

```go
func main() {
  ctx, cancel := context.WithCancel(context.Background())
  defer cancel() // this cancel signal gets called when main exits

  go func() {
    CreateFileWatcher(ctx, "foo.txt")
  }()
  // ...
}
```

## Context values

Key value pairs can also be passed with a context

```go
// best practice for context keys is to use a custom, unexported type
// this avoids any possible collisions
type key string
const myCustomKey key = "key"
ctx := context.WithValue(parentCtx, "key", "value")
fmt.Println(ctx.Value("key"))
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
