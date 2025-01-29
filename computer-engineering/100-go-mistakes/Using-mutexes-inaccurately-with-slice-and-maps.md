---
title: Using mutexes inaccurately with slices and maps
layout: idea
tags:
  - 100-go-mistakes
---

# Using mutexes inaccurately with slices and maps

## Mistake

This creates a data race. Internally a map is a runtime.hmap struct containing
mostly metadata and a pointer referencing the actual data. The same holds true
for slices

```go
type Cache struct {
  mu sync.RWMutex
  balances map[string]float64
}

func (c *Cache) AddBalance(id string, balance float64) {
  c.mu.Lock()
  c.balances[id] = balance
  c.mu.Unlock()
}

func (c *Cache) AverageBalance() float64 {
  c.mu.RLock()
  // this does not copy the data, just a pointer to the data
  balances := c.balances
  c.mu.RUnlock()

  sum := 0
  for _, balance := range balances {
    sum += balance
  }

  return sum / float64(len(balances))
}
```

## Fix

Alternatively, we could make a deep copy of the map/slice by iterating over all
of it's elements and inserting them into a new copy.

```go
func (c *Cache) AverageBalance() float64 {
  c.mu.RLock()
  defer c.mu.RUnlock()

  balances := c.balances

  sum := 0
  for _, balance := range balances {
    sum += balance
  }

  return sum / float64(len(balances))
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
