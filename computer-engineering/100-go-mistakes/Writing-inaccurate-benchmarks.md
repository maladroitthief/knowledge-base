---
title: Writing inaccurate benchmarks
layout: idea
tags:
  - 100-go-mistakes
---

# Writing inaccurate benchmarks

## Not resetting or pausing the timer

```go
func BenchmarkFoo(b *testing.B) {
  setup()
  b.ResetTimer()
  for i := 0; i < b.N; i++ {
    foo()
  }
}
```

```go
func BenchmarkFoo(b *testing.B) {
  for i := 0; i < b.N; i++ {
    b.StopTimer()
    setup()
    b.StartTimer()
    foo()
  }
}
```

## Micro-benchmarks

```go
func BenchmarkAtomicStoreInt32(b *testing.B) {
  var v int32
  for i := 0; i < b.N; i++{
    atomic.StoreInt32(&v, 1)
  }
}

func BenchmarkAtomicStoreInt64(b *testing.B) {
  var v int64
  for i := 0; i < b.N; i++ {
    atomic.StoreInt64(&v, 1)
  }
}
```

Run the benchmark multiple times and evaluate statistics using `benchstat`

```shell
go test -bench=. -count=10 | stats.txt
benchstat stats.txt
```

## Compiler optimizations

This function is likely to be in-lined, making the benchmark useless

```go
const m1 = 0x5555555555555555
const m2 = 0x3333333333333333
const m4 = 0x0f0f0f0f0f0f0f0f
const h01 = 0x0101010101010101

func popcnt(x uint64) uint64 {
  x -= (x >> 1) & m1
  x = (x & m2) + ((x >> 2) & m2)
  x = (x + (x >> 4)) & m4
  return (x * h01) >> 56
}
```

We can avoid in-lining by forcing the function to write to a local variable and
then write to a variable outside of the function scope.

```go
var global uint64

func BenchmarkPopcnt(b *testing.B) {
  var v uint64

  for i := 0; i < b.N; i++ {
    // assign a local variable
    v = popcnt(uint64(i))
  }

  // assign the latest value to a global
  global = v
}
```

## Observer effect

### Mistake

Reusing the same resources will result in the CPU caching the data and we end up
benchmarking cache misses

```go
const rows = 1000
var res int64

func BenchmarkCalculateSum512(b *testing.B) {
  var sum int64
  s := createMatrix512(rows)
  b.ResetTimer()

  for i := 0; i < b.N; i++ {
    // we keep reusing the same matrix
    sum = calculateSum(s)
  }
  res = sum
}
```

### Fix

```go
func BenchmarkCalculateSum512(b *testing.B) {
  var sum int64
  for i := 0; i < b.N; i++ {
    b.StopTimer()
    // create a new matrix to avoid caching
    s := createMatrix512(rows)
    b.StartTimer()
    sum = calculateSum512(s)
  }
  res = sum
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
