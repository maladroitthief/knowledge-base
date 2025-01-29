---
title: Not using nil channels
layout: idea
tags:
  - 100-go-mistakes
---

# Not using nil channels

## Mistake

In this version, ch1 blocks ch2 until ch1 is closed. This would be a problem if
ch1 stays open forever.

```go
func merge(ch1, ch2 <-chan int) <-chan int {
  ch := make(chan int, 1)

  go func() {
    for v := range ch1 {
      ch <- v
    }

    for v := range ch2 {
      ch <- v
    }
    close(ch)
  }()

  return ch
}
```

## Fix

Make the channel nil when it is no longer open

```go
func merge(ch1, ch2 <- chan int) <-chan int {
  ch := make(chan int, 1)

  go func(){
    for ch1 != nil || ch2 != nil {
      select {
      case v, open := <-ch1:
        if !open {
          ch1 = nil
          break
        }
        ch <- v
      case v, open := <-ch2:
        if !open {
          ch2 = nil
          break
        }
        ch <- v
      }
    }
    close(ch)
  }()

  return ch
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
