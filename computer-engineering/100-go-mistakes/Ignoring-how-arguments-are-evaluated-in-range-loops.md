---
title: Ignoring how arguments are evaluated in range loops
layout: idea
tags:
  - 100-go-mistakes
---

# Ignoring how arguments are evaluated in range loops

When using a range loop, the provide expression is evaluated once.

## Mistake

```go
a := [3]int{0, 1, 2}
for i, v := range a {
  a[2] = 10

  if i == 2 {
    fmt.Println(v) // this will print 2, not 10
  }
}
```

## Fix

Don't use the range variables if you are modifying the range expression.

```go
a := [3]int{0, 1, 2}
for i := range a {
  a[2] = 10

  if i == 2 {
    fmt.Println(a[2]) // this will print 10
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
