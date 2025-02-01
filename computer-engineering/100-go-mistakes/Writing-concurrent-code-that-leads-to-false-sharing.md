---
title: Writing concurrent code that leads to false sharing
layout: idea
tags:
  - 100-go-mistakes
---

# Writing concurrent code that leads to false sharing

## Mistake

This example works from a concurrency perspective, but it is in example of false
sharing and can result in poor performance. Since `sumA` and `sumB` are
allocated contiguously, they more than likely will be placed on the same block.
When the these goroutines end up getting scheduled to different cores, the CPU
will need to copy this block of memory twice. Due to cache coherency, even
though each goroutine is only modifying it's respective `sum`, the CPU only
tracks the cache line.

With a shared cache line when one Goroutine is modifying it, the entire cache
line is invalidated. This is false sharing and degrades performance.

```go
type Input struct {
  a int64
  b int64
}

type Result struct {
  sumA int64
  sumB int64
}

func count(inputs []Input) Result {
  wg := sync.WaitGroup{}
  wg.Add(2)

  result := Result{}

  go func() {
    for i := 0; i < len(inputs); i++ {
      result.sumA += inputs[i].a
    }
    wg.Done()
  }()

  go func() {
    for i := 0; i < len(inputs); i++ {
      result.sumB += inputs[i].b
    }
    wg.Done()
  }()

  wg.Wait()
  return result
}
```

## Fix

We can either add padding to the Result struct or consider reworking our
approach.

```go
type Result struct {
  sumA int64
  _ [56]byte // Add enough padding to force a new cache line
  sumB int64
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
