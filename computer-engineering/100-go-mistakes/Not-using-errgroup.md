---
title: Not using errgroup
layout: idea
tags:
  - 100-go-mistakes
---

# Not using errgroup

## Mistake

This code correctly handles the aggregation of results with no data races, but
has no solution for error handling.

```go
func handler (ctx context.Context, circles []Circle) ([]Result, error) {
  results := make([]Result, len(circles))
  wg := sync.WaitGroup{}
  wg.Add(len(results))

  for i, circle := range circles {
    // variable shadowing to avoid data race
    i := i
    circle := circle

    go func() {
      defer wg.Done()

      result, err := foo(ctx, circle)
      if err != nil {
        // ??????
      }
      results[i] = result
    }()
  }

  wg.Wait()
}
```

## Fix

```go
func handle(ctx context.Context, circles []Circle) ([]Result, error) {
  results := make([]Result, len(circles))
  g, ctx := errgroup.WithContext(ctx)

  for i, circle := range circles {
    i := i
    circle := circle

    g.Go(func() error {
      result, err := foo(ctx, circle)
      if err != nil {
        return err
      }

      results[i] = result
      return nil
    })
  }

  err := g.Wait()
  if err != nil {
    return nil, err
  }

  return results, nil
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
