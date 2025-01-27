---
title: Checking an error type inaccurately
layout: idea
tags:
  - 100-go-mistakes
---

# Checking an error type inaccurately


## Mistake

This stops working with wrapped errors

```go
if err != nil {
  switch err := err.(type) {
  case transientError:
    http.Error(w, err.Error(), http.StatusServiceUnavailable)
  default:
    http.Error(w, err.Error(), http.StatusBadRequest)
  }
  return
}
```

## Fix

Use the `errors.As()` function

```go
if err != nil {
  if errors.As(err, &transientError{}){
    http.Error(w, err.Error(), http.StatusServiceUnavailable)
  } else {
    http.Error(w, err.Error(), http.StatusBadRequest)
  }
  return
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
