---
title: Misusing sync.WaitGroup
layout: idea
tags:
  - 100-go-mistakes
---

# Misusing sync.WaitGroup

`sync.WaitGroup` is a mechanism to wait for `n` operations to complete.

## Mistake

This is a data race, there is no guarantee that another goroutine will be
started before the wg.Done() method is called causing the wg.Wait() to stop
blocking.

```go
wg := sync.WaitGroup{}
var v uint64

for i := 0; i < 3; i++ {
  go func(){
    wg.Add(1)
    atomic.AddUint64(&v, 1)
    wg.Done() // this is a data race
  }()
}
wg.Wait()
```

## Fix

We can move the `wg.Add(1)` outside of the goroutine or alternatively we could
call `wg.Add(3)` outside of the for loop.

```go
wg := sync.WaitGroup{}
var v uint64

for i := 0; i < 3; i++ {
  wg.Add(1)
  go func(){
    atomic.AddUint64(&v, 1)
    wg.Done() // this is a data race
  }()
}
wg.Wait()
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
