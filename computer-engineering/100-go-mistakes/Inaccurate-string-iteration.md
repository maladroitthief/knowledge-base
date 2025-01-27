---
title: Inaccurate string iteration
layout: idea
tags:
  - 100-go-mistakes
---

# Inaccurate string iteration

## Mistake

This does not print `ê`, but instead prints `Ã` and the length is printed to be
6 instead of 5. This is because the character `ê` requires 2 bytes to store.

```go
s := "hêllo"

for i := range s {
  fmt.Printf("position %d: %c\n", i, s[i])
}

fmt.Printf("len=%d\n", len(s))
```

## Fix

Use range variables

```go
s := "hêllo"

for i, r := range s {
  fmt.Printf("position %d: %c\n", i, r)
}
```

Cast the string to a rune slice

```go
s := "hêllo"
runes := []rune(s)

for i := range runes {
  fmt.Printf("position %d: %c\n", i, runes[i])
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
