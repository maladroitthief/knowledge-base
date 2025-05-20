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

If the compiler cannot discern that the order of operations is unimportant, then
it cannot do work ahead of time. When translating code to an intermediate form,
some compilers will use Static Single Assignment (SSA) form. SSA is the idea
that a variable is never modified after initialization and instead new variables
are created for any mutations.

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
algorithms are slow due to memory look-ups are chained together. Using a wide
node algorithm like a B-Tree or a B\*-Tree can make map/sets significantly
faster. This also goes for using pointer based composition. Requiring memory
lookups for each component restricts the compiler from being able to work ahead
of time.

## Write buffer awareness

The same considerations need to be taken for writing as well as reading. Keep
data contiguous and isolate mutable and immutable values. Keeping transforms
simple also allows the compiler to bypass the cache entirely. This data
streaming can be valuable in avoiding the pollution of the cache.

## Aliasing

<!-- TODO: Finish this section -->

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
