---
title: Helping the Compiler
layout: idea
tags:
  - data-oriented-design
---

# Helping the Compiler

While compilers are good at optimizing code, they are not magic wands. It is the
engineer's job to write code that the compiler can reason with and better apply
it's optimizations.

> "You don't have to be an engineer to be a racing driver, but you do have to
> have Mechanical Sympathy."
>
> \- Jackie Stewart

## Reducing order dependence

Compilers try doing work ahead of time to increase performance. If the compiler
cannot discern that the order of operations is unimportant, then it cannot do
work ahead of time. When translating code to an intermediate form, some
compilers will use Static Single Assignment (SSA) form. SSA assumes that a
variable is never modified after initialization and instead new variables are
created for any mutations. This is useful because it allows the compiler to work
ahead of time, this is especially true with branches.

Here is an example of a function that is not conductive to SSA:

```go
func processDataBefore(data []int) int {
  result := 0

  // Temporary variable reused across loop iterations
  temp := 0

  for i := 0; i < len(data); i++ {
    // The use of 'temp' is separated from its definition,
    // and its value changes for each iteration.
    temp = data[i] * 2

    if data[i] % 2 == 0 {
      result += temp - 5
    } else {
      result += temp + 3
    }
  }
  return result
}
```

This code can be re-written to be more SSA conducive:

```go
func processDataAfter(data []int) int {
  result := 0

  for i := 0; i < len(data); i++ {
    // The lifetime of 'currentValueDoubled' is confined to this iteration.
    currentValueDoubled := data[i] * 2

    if data[i] % 2 == 0 {
      result += currentValueDoubled - 5
    } else {
      result += currentValueDoubled + 3
    }
  }

  return result
}
```

## Reducing memory dependency

Linked lists are expensive due to memory dependency. Pointer driven tree
algorithms are slow due to memory look-ups that are chained together. We cannot
load memory ahead of time if we are constantly following pointers. Using a wide
node algorithm like a B-Tree or a B\*-Tree can make map/sets significantly
faster. This also goes for using pointer based composition. Requiring memory
lookups for each component restricts the compiler from being able to work ahead
of time. Avoiding these pointer hops reduces the amount of time we are stalled
waiting for main memory.

## Write buffer awareness

The same considerations need to be taken for writing as well as reading. Keep
data contiguous in large amounts and isolate mutable and immutable values.
Keeping transforms simple also allows the compiler to bypass the cache entirely.
This data streaming can be valuable in avoiding the pollution of the cache and
also can enable other compiler optimizations.

## Aliasing

Aliasing is when pointers are referencing the same memory. This will require
reloads between reads if the other pointer has been written to. When possible
try to pass by value instead of by reference to minimize the amount of aliasing.

## Return value optimization

Return value optimization is returning multiple values either by reference or
using some form of data structure. Returning by value is very cheap as most
compilers can make this a non-copy operation.

## Cache line utilization

A single memory request will read in at least one cache line and a cache line is
almost always 64 bytes. When loading objects from memory, calculate the
difference between the object's size and the cache line. This number is the
amount of memory that you can read for free.

## False sharing

CPU cores can be impacted by the cache even when they are not sharing data.
Although this is very uncommon, when writing data to the same cache line, we can
interfere with threading. Multiple threads want to read and write to the same
cache line, but not to the same memory address. Before assuming that false
sharing is impacting your performance, verify that this is actually happening.

## Speculative execution awareness

Speculative execution awareness is executing instructions before they are
needed. This is a problem for pre-fetching data for branch prediction reads, but
this can be avoided. If the conditional predicate is calculated ahead of time it
can be cached and help mitigate this issue.

## Branch prediction

One of the main causes for stalling in a CPU is having to undo work because of a
bad branch prediction. This can result in wasted memory bandwidth and the
correct branch will either need to be started or continued. The easiest way to
prevent this is to minimize the amount of branching your code requires or to
better understand the branch prediction mechanism of the CPU. If branch
prediction is trivial, then the CPU will get it right more often than not.

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
