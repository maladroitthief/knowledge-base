---
title: Not being careful with goroutines and loop variables
layout: idea
tags:
  - 100-go-mistakes
---

# Not being careful with goroutines and loop variables

## Mistake

```go
s := []int{1, 2, 3}

for _, i := range s {
  go func() { // This is a closure and when it access `i` is not guaranteed
    fmt.Print(i)
  }()
}
```

## Fix

```go
s := []int{1, 2, 3}

for _, i := range s {
  // this variable is now local to each scope
  val := i
  go func() {
    fmt.Print(val)
  }()
}
```

```go
s := []int{1, 2, 3}

for _, i := range s {
  // we pass the value as a parameter so it is evaluated immediately
  go func(val int) {
    fmt.Print(val)
  }(i)
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
