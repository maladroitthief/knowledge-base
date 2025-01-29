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
// best practice for context keys is to use a custom, un-exported type
// this avoids any possible collisions
type key string
const myCustomKey key = "key"

ctx := context.WithValue(parentCtx, myCustomKey, "value")
fmt.Println(ctx.Value("key"))
```

### Use cases

Context values have wide use cases such as tracing IDs or middle-ware

```go
type key string

const isValidHostKey key = "isValidHost"

func checkValid(next http.Handler) http.Handler {
  return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
    validHost := r.Host == "acme"
    ctx := context.WithValue(r.Context(), isValidHostKey, validHost)

    next.ServeHTTP(w, r.WithContext(ctx))
  })
}
```

## Catching a context cancellation

The context.Context type exports a `Done` method that returns a receive only
notification channel `<-chan struct{}`. This closes when:

- the `cancel` function is called
- the deadline has expired

context.Context also exports an `Err` method that returns `nil` if the `Done`
channel is not closed. When it is not nil, it is either context.Canceled or
context.DeadlineExceeded.

```go
func handler(ctx context.Context, ch chan Message) error {
  for {
    select {
      // keep reading messages
      case msg := <-ch:
        // ...
      // context is done
      case <-ctx.Done():
        return ctx.Err()
    }
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
