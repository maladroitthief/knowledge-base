---
title: Starting a goroutine without knowing when to stop it
layout: idea
tags:
  - 100-go-mistakes
---

# Starting a goroutine without knowing when to stop it

## Mistake

It is unclear when this goroutine will stop. The channel implementation in foo()
is unknown. If this never closes then it is a leak.

```go
ch := foo()

go func(){
  for v := range ch {
    // ...
  }
}()
```

## Fix

We instead should be signaling resources letting them know it is time to close

```go
func main() {
  w := newWatcher()
  defer w.close()

  // ...
}

func newWatcher() watcher {
  w := watcher{}
  go w.watch()

  return w
}

func (w watcher) close(){
  // close resource
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
