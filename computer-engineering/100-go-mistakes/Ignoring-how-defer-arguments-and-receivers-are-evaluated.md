---
title: Ignoring how defer arguments and receivers are evaluated
layout: idea
tags:
  - 100-go-mistakes
---

# Ignoring how defer arguments and receivers are evaluated

## Mistake

`defer` arguments are evaluated immediately. No matter what status is changed to
it will always be an empty string for these two defer statements. The same holds
true for function receivers.

```go
func f() error {
  var status string
  defer notify(status)
  defer incrementCounter(status)
  // ...
}
```

## Fix

Passing a pointer would allow mutations to the status variable to be reflected
by defer. Using a pointer receiver would have the same effect.

```go
func f() error {
  var status string
  defer notify(&status)
  defer incrementCounter(&status)
  // ...
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
