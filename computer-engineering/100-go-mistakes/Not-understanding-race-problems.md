---
title: Not understanding race problems
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding race problems

Race problems can be among the hardest and most insidious bugs to fix.

## Multiple goroutines data races

### Mistake

```go
i := 0

go func() {
  i++
}()

go func() {
  i++
}()
```

### Fix

#### Using atomic operations

```go
var i int64

go func() {
  atomic.AddInt64(&i, 1)
}()

go func() {
  atomic.AddInt64(&i, 1)
}()
```

#### Using mutexes

```go
i := 0
mutex := sync.Mutex{}

go func() {
  mutex.Lock()
  i++
  mutex.Unlock()
}()

go func() {
  mutex.Lock()
  i++
  mutex.Unlock()
}()
```

#### Using channels

```go
i := 0
ch := make(chan int)

go func() {
  ch <- 1
}()

go func() {
  ch <- 1
}()

i += <-ch
i += <-ch
```

## Channel data races

### Mistake

#### Synchronizing

```go
i := 0
go func() {
  i++ // Racer
}()

fmt.Println(i) // Racer
```

#### Buffered channels

```go
i := 0
ch := make(chan struct{}, 1) // buffered

go func() {
  i = 1
  <-ch // A buffered receive happens before a send
}()

ch <- struct{}{}
fmt.Println(i)
```

### Fix

#### Synchronizing

```go
i := 0
ch := make(chan struct{})

go func() {
  <-ch // this receive blocks until channel send
  fmt.Println(i)
}()

i++
// alternatively we could close this channel for the same effect
ch <- struct{}{} // channel send
```

#### Buffered channels

```go
i := 0
ch := make(chan struct{}) // unbuffered

go func() {
  i = 1
  <-ch
}()

ch <- struct{}{}
fmt.Println(i)
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
