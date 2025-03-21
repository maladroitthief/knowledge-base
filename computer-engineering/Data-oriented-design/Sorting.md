---
title: Sorting
layout: idea
tags:
  - data-oriented-design
mermaid: true
---

# Sorting

Sorting is important, however it is not always necessary and can cause more
performance problems than it's worth. There are algorithms that may seem like
they require sorted data, but ultimately don't. On the other hand, some
algorithms can appear to not need sorted data when in reality they do.

Be aware of how accurately the data needs to be sorted since unstable sorts are
often quicker. For analog ranges, a quick sort or merge sort are slow, but will
guarantee accurate sorting. For a discrete range with a large number of
elements, a radix sort is the best fit. If the range of values is known at
compile time, then a counting sort is a very fast two-pass sort.

Some sorting algorithms can be specialized for partial sorting, like finding the
lowest/highest `m` numbers in an array. Quick-select can return the `n`th item
by sorting criteria in the `n`th position.

With a general range of items that need sorted two different ways, they can be
sorted with a specialized comparison function in a one-hit sort or can be sorted
hierarchically. This can be beneficial if the order for a subset is less
important than the order of the full range.

## Maintain by insertion sort or parallel merge sort

Depending on what you need the list sorted for, it is possible to sort while
modifying the list. For a function that cares about priority, you might as well
use insertion sort since the base heuristic commonly has completely orthogonal
inputs. If the inputs are related, then a post insertion table wide sort could
be appropriate.

For full scale sorting, use an algorithm that can be used in parallel. Merge
sort and quick sort are serial in that they end/start with a single thread doing
all the work, but some variants can work with multi-threading. For small
data-sets, there are special sorting network techniques that are faster than
better algorithms just because they fit the hardware better.

## Sorting for the platform

Always remember that in data oriented design you must consider the data before
all else. What does the data look like? If you want to be able to profile and
iterate quickly then having some flexibility with sorting criteria is crucial.
More rigid sorting techniques can still work, but they will require additional
setup costs.

Radix sort is the fastest serial sort. This is because it can generate a list of
starting points for data of different values in a first pass, and then operates
using that data on the second pass. This should be a strong consideration for
any simple data sets. Radix sort struggles with non-integer or non-fixed size
keys and also requires a lot of auxiliary memory.

If the data is not simple enough to radix sort, then it might be better off
using a merge-sort or quick-sort. However, if the length of the buffer is known
at compile time, other sorts can be better, such as sorting networks. While
merge-sort is not technically concurrent, the initial merges can be done in
parallel with only the final merge being serial. Even the final merge can be
done with a thread on each end instead of just a single thread. Quick-sort is
also not concurrent, but it's sub-stages can be run in parallel. This makes
either of these inherently serial algorithms into partially concurrent
algorithms with a latency of `O(log n)`.

If `n` is small enough, an in-place bubble sort can be great. It's simple enough
that it's hard to mess up and because it has a small number of swaps, it has
much less overhead than some of the technically more efficient algorithms.
Additionally, bubble sort is so trivially small that the inline implementations
can be small enough that both the data and instructions fit in the cache. This
makes it's inefficient performance negligible, but only if `n` is small. This
size will vary from platform to platform so profiling is required to be certain,
but 100 elements is a reasonable estimate for the tipping point.

When working with data-oriented transformations, it's common to take a table of
`n` items and produce a sorted version. While there are many algorithms that are
better than bubble sort, it requires little development time to replace the
bubble sort transform in the future. The data is already in the right shape for
this transformation, so the implementation is just details.

### Sorting networks

Sorting networks work by implementing the sort in a static manner. They take a
fixed number of inputs and swap, if necessary, on value pairs before outputting
the result.

The simplest sorting network is two inputs:

```
A --> --> --> A'
      \ /
       X
      / \
B --> --> --> B'
```

If the values are entered in order then the cross-over does nothing. If they are
out of order, the cross-over swaps the values. This can be implemented as
branch-free writes:

```go
a0 := max(a, b)
b0 := min(a, b)
```

This is fast on any hardware. Min and Max will need different implementations
for each platform and data type, but in general branch-free code executes faster
than code with branching.

Adding more elements

```
A ---> | -1-> | -2-> | -3-> | ---> A'
        \     /\   /
         \   /   X
          \ /  /   \
B ---> | -1-> | -2-> | -3-> | ---> B'
        \ / \ /       \   /
         X   X          X
        / \ / \       /   \
C ---> | -1-> | -2-> | -3-> | ---> C'
          / \   \   /
         /   \    X
        /     \ /   \
D ---> | -1-> | -2-> | -3-> | ---> D'
```

Notice the critical path is only 3 stages. The initial stage is two concurrent
sortings of A/C and B/D pairs. The second stage then becomes A/B and C/D pairs
and then finally we end on sorting B/C. This is entirely branch-less and the
performance is regular over all data permutations. Having a regular performance
profile, we can use sorting networks when timing needs to be consistent, like
for just in time sorting. We can also combine techniques, like radix sorting
subsets and then network sorting the final result to guarantee a consistent
timing.

```go
a0 := max(a, c)
b0 := min(b, d)
c0 := max(a, c)
d0 := min(b, d)
a00 := max(a0, b0)
b00 := min(a0, b0)
c00 := max(c0, d0)
d00 := min(c0, d0)
b000 := min(b00, c00)
c000 := max(b00, c00)
```

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
