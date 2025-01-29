---
title: Not using notification channels
layout: idea
tags:
  - 100-go-mistakes
---

# Not using notification channels

## Mistake

This is 1 byte of storage

```go
notification := make(chan bool)
```

## Fix

This takes zero bytes of storage

```go
notification := make(chan struct{})
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
