---
title: Copying a sync type
layout: idea
tags:
  - 100-go-mistakes
---

# Copying a sync type

All primitive types in the `sync` package follow one hard rule, they should
**never** be copied.

- sync.Cond
- sync.Map
- sync.Mutex
- sync.RWMutex
- sync.Once
- sync.Pool
- sync.WaitGroup

## Mistake

This is an example of a data race from copying a sync primitive.

```go
type Counter struct {
  mu sync.Mutex
  counters map[string]int
}

func NewCounter() Counter {
  return Counter{counters: map[string]int{}}
}

// The function receiver here is a value so it is copied instead of referenced
func (c Counter) Increment(name string){
  c.mu.Lock()
  defer c.mu.Unlock()

  c.counters[name]++
}
```

## Fix

Alternatively, we could make `Counter.mu` a pointer to a `sync.Mutex`

```go
type Counter struct {
  mu sync.Mutex
  counters map[string]int
}

func NewCounter() Counter {
  return Counter{counters: map[string]int{}}
}

func (c *Counter) Increment(name string){
  c.mu.Lock()
  defer c.mu.Unlock()

  c.counters[name]++
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
