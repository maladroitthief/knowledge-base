---
title: Not understanding CPU caches
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding CPU caches

## CPU Architecture

Modern CPUs rely on caching to speed up memory access. In most cases there are
three caching levels:

- L1: ~1ns
  - L1D: data
  - L1I: instructions
- L2: ~4ns
- L3: ~10ns
- Main Memory ~500-1,000ns

Additionally a CPU can be hyper-threaded, where a physical core is split into
multiple logical cores (virtual cores). The L1 and L2 caches are **on-die**,
meaning they are the same piece of silicon as the rest of the processor. The L3
cache is **off-die**, making it much slower than the L1 and L2.

## Cache line

When specific memory is accessed, one of the following is likely to happen:

- **Temporal Locality**: It will be referenced again
- **Spatial Locality**: Nearby memory will be referenced

This is called the **locality of reference**. Temporal locality is part of the
reason for needing a CPU cache, repeated accessing to the same variable. Spatial
locality is why the CPU copies a **cache-line** instead of a single variable
from main memory to the cache.

A cache-line is a continuous memory segment of a fixed size, usually 64 bytes.
When a CPU caches a memory block from RAM, it copies that block to a cache-line.
Since memory is a hierarchy, the CPU will check the L1, L2, L3, and then finally
main memory when it is trying to access a specific memory location.

When first accessing memory we get a cache miss, also known as a **compulsary
miss**. The processor will load that block into a cache-line resulting in cache
hits for nearby memory locations.

## Array of structs vs. Struct of arrays

```go
// Array of structs (AoS)
type Foo struct {
  a int64
  b int64
}

func sumFoo(foos []Foo) int64 {
  var total int64
  for i := 0; i < len(foos); i++ {
    total += foos[i].a
  }
  return total
}

// Struct of arrays (SoA)
type Bar struct {
  a []int64
  b []int64
}

func sumBar(bar Bar) int64 {
  var total int64
  for i := 0; i < len(bar.a); i++ {
    total += bar.a[i]
  }
  return total
}
```

The memory layout for array of structs looks like the following:

|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b|a|b| | cache line |
cache line | cache line | cache line |

Where as the memory layout of the struct of array looks like this:

|a|a|a|a|a|a|a|a|a|a|a|a|a|a|a|a|b|b|b|b|b|b|b|b|b|b|b|b|b|b|b|b| | cache line |
cache line | cache line | cache line |

Both examples have the same amount of data, but with the struct of arrays the
elements are all continuous in memory. If our goal is only to read the elements
of `a`, the Array of Structs approach takes 4 cache lines, but the Struct of
Arrays method takes only 2 cache lines.

## Predictability

Predictability is the ability of a CPU to anticipate what the application will
do in order to speed up its execution. One of the ways a CPU can do this is
stride, or how it works through data.

- **Unit stride**: All values being accessed are allocated continuously
  - Example: []int64, Struct of Arrays
  - Highly predictable, very efficient
- **Constant stride**: Some values are accessed at fixed stride
  - Example: []Foo, Array of Structs
  - Need to skip over some elements
  - Predictable, less efficient
- **Non-unit stride**: A stride that cannot be predicted
  - Example: linked list, array of pointers
  - Unpredictable, no cache lines will be fetched

## Cache placement policy

A **full associative cache** with a L1D cache of 32KB and a 64 byte cache-line,
if a block is placed randomly into the L1D, the CPU will have to iterate over
512 cache lines in the worst case to read a variable.

A **set-associative cache** is partitioned into sets, usually two-way, meaning
that every set contains two cache lines. A memory block can belong to only one
set, and it's placement is determined by it's memory address. A block can be
broken down into:

- **block offset**: Based on block size. For 512 bytes (2^**9**), the first 9
  bits represent the block offset (bo)
- **set index**: The set it's address belongs to. For two-way set associative
  with 512 lines, we have 512 / 2 = 256 sets (2^**8**), the next 8 bits
  represent the set index (si).
- **tag bits**: A unique identifier for the block. Based on main memory size.
  For 524,288 bytes in main memory, we have log2(524,288) - **bo** - **si**
  (19 - 9 - 8), the next 2 bits represent the tag bits (tb).

Consider the following memory accesses. Each row will indicate a memory read and
the corresponding CPU operation given a two-way set associative cache:

| Memory Address          | tb     | si            | bo              | CPU Operation                           |
| ----------------------- | ------ | ------------- | --------------- | --------------------------------------- |
| `0x0000_0000_0000_0000` | `0b00` | `0b0000_0000` | `0b0_0000_0000` | Miss, copy address to set 0             |
| `0x5000_0000_0000_0000` | `0b01` | `0b0000_0000` | `0b0_0000_0000` | Miss, copy address to set 0             |
| `0x7000_0000_0000_0000` | `0b10` | `0b0000_0000` | `0b0_0000_0000` | Miss, replace a value in set 0 (~LRU)   |
| `0x0000_0000_0000_0000` | `0b00` | `0b0000_0000` | `0b0_0000_0000` | Conflict miss, replace a value in set 0 |

A **conflict miss** occurs when we keep missing addresses in the same set. This
would not occur is a full associative cache, but in a set-associative cache
where all the accessed variables end up with the same set index, we end up using
just one cache set instead of having a distribution across the whole cache. This
is called **critical stride**. For example, if we have a 32 KB, eight-way
set-associative L1D cache (64 sets) and a cache line is 64 bytes, any continuous
structure that has 64 x 64 = 4KB of memory will have **critical stride**. This
would be a `[512]int64` or a `[1024]int32` resulting in poor caching
distribution.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
