---
title: Not knowing how to reduce allocations
layout: idea
tags:
  - 100-go-mistakes
---

# Not knowing how to reduce allocations

## API changes

### Mistake

Returning a slice is **sharing up** and causes the slice to escape the stack and
get allocated on the heap.

```go
type Reader interface {
  Read(n int) (p []byte, err error)
}
```

### Fix

Passing the slice as a parameter is an example of **sharing down** and the slice
is able to be allocated on the stack instead of the heap.

```go
type Reader interface {
  Read(p []byte) (n int, err error)
}
```

## Compiler optimizations

In the event we would want to create a map with a `[]byte` key, we would write
the following:

```go
type cache struct {
  m map[string]int
}

func (c *cache) get(bytes []byte) (v int, contains bool) {
  key := string(bytes)
  v, contains := c.m[key]
  return
}
```

However, if we rewrite this to query the map directly, we can avoid the bytes to
string conversion entirely using a Go compiler optimization:

```go
func (c *cache) get(bytes []byte) (v int, contains bool) {
  v, contains := c.m[string(bytes)] // queries the map directly
  return
}
```
## sync.Pool

`sync.Pool` is a pool for re-using common objects.

```go
func write(w io.Writer) {
  b := getResponse() // returns a new []byte on every call
  _, _ = w.Write(b)
}
```

We can reduce these allocations using `sync.Pool`.

```go
var pool = sync.Pool{
  New: func() any {
    return make([]byte, 1024)
  }
}

func write(w io.Writer) {
  buffer := pool.Get().([]byte) // Get or create buffer from pool
  buffer = buffer[:0] // reset buffer
  defer pool.Put(buffer) // release buffer back to the pool

  getResponse(buffer)
  _, _ = w.Write(buffer)
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
