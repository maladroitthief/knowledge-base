---
title: Checking an error value inaccurately
layout: idea
tags:
  - 100-go-mistakes
---

# Checking an error value inaccurately

## Mistake

```go
if err == sql.ErrNoRows {

}
```

## Fix

```go
if errors.Is(err, sql.ErrNoRows) {

}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
