---
title: Forgetting the return after replying to an HTTP request
layout: idea
tags:
  - 100-go-mistakes
---

# Forgetting the return after replying to an HTTP request

## Mistake

```go
func handler(w http.ResponseWriter, req *http.Request) {
  err := foo(req)
  if err != nil {
    // this doesn't stop the function
    http.Error(w, "foo", http.StatusInternalServerError)
  }

  // ...
}
```

## Fix

```go
func handler(w http.ResponseWriter, req *http.Request) {
  err := foo(req)
  if err != nil {
    http.Error(w, "foo", http.StatusInternalServerError)
    return
  }

  // ...
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
