---
title: Not relying on inlining
layout: idea
tags:
  - 100-go-mistakes
---

# Not relying on inlining

Inlining is replacing a function call with the body of the function, usually
done automatically by the compiler. In Go, this can be observed by running
`go build -gcflags`. This only works if the function falls within the **inlining
budget**, otherwise the function is too complex to be inlined.

Inlining offers two benefits: removing the function call overhead and enabling
more compiler optimizations. **Mid-stack Inlining** is inlining functions that
call other functions. This is useful because it allows for **fast-path
inlining**, distinguishing between fast and slow paths.

## Mistake

There are clearly two primary paths in this function. The mutex isn't locked
(fast) and the mutex is locked (slow).

```go
func (m *Mutex) Lock() {
  if atomic.CompareAndSwapInt32(&m.state, 0, mutexLocked) {
    // mutex is not locked
    if race.Enabled {
      race.Acquire(unsafe.Pointer(m))
    }
    return
  }

  // mutex is already locked
  var waitStartTime int64
  starving := false
  awoke := false
  iter := 0
  for {
    // complicated logic
  }

  if race.Enabled {
    race.Acquire(unsafe.Pointer(m))
  }
}
```

## Fix

The `Lock()` method can now be inlined.

```go
func (m *Mutex) Lock() {
  if atomic.CompareAndSwapInt32(&m.state, 0, mutexLocked) {
    // mutex is not locked
    if race.Enabled {
      race.Acquire(unsafe.Pointer(m))
    }
    return
  }
  m.lockSlow()
}

func (m *Mutex) lockSlow() {
  // mutex is already locked
  var waitStartTime int64
  starving := false
  awoke := false
  iter := 0
  for {
    // complicated logic
  }

  if race.Enabled {
    race.Acquire(unsafe.Pointer(m))
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
