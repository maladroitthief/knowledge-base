---
title: Propagating an inappropriate context
layout: idea
tags:
  - 100-go-mistakes
---

# Propagating an inappropriate context

## Mistake

This creates a race condition between the two internal requests

```go
func handler(w http.ResponseWriter, w *http.Request) {
  response, err := doSomeTask(r.Context(), r)
  if err != nil {
    http.Error(w, err.Error(), http.StatusInternalServerError)
    return
  }

  go func() {
    err := publish(r.Context(), response) // this is a race condition
    // error handling
  }()

  writeResponse(response)
}
```

## Fix

```go
// We wrap the context and implement the Context interface
type detach struct {
  ctx context.Context
}

func (d detach) Deadline() (time.Time, bool) {
  return time.Time{}, false
}

func (d detach) Done() <-chan struct{} {
  return nil
}

func (d detach) Err() error {
  return nil
}

func (d detach) Value(key any) any {
  return d.ctx.Value(key)
}

func handler(w http.ResponseWriter, w *http.Request) {
  response, err := doSomeTask(r.Context(), r)
  if err != nil {
    http.Error(w, err.Error(), http.StatusInternalServerError)
    return
  }

  go func() {
    // Wrapping this detaches the cancellation signal while preserving the
    //   original Values
    err := publish(detach{r.Context()}, response)
    // error handling
  }()

  writeResponse(response)
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
