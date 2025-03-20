---
title: Sorting
layout: idea
tags:
  - data-oriented-design
---

# Sorting

For some systems, sorting is critically important, however it is not always
necessary and can cause more performance problems than it's worth. There are
algorithms that may seem like they require sorted data, but don't and vice
versa.

Be aware of how accurate the data needs to be sorted. Unstable sorts can often
be quicker. For analog ranges, a quick sort or merge sort are slow, but
guarantee accurate sorting. For a discrete range with a large `n`, a radix sort
is more appropriate. If the range of values is known, then a counting sort is a
very fast two-pass sort.

Some sorting algorithms are also specialized for partial sorting, like finding
the lowest/highest `m` numbers of an array. Quick-select can return the `n`th
item by sorting criteria in the `n`th position.

With a general range of items that need sorted two different ways, they can be
sorted with a specialized comparison function in a one-hit sort or can be sorted
hierarchically. This can be beneficial if the order for a subset is less
important than the order of the full range.

## Maintain by insertion sort or parallel merge sort

Depending on what you need the list sorted for, it is possible to sort while
modifying. For some function that cares about priority, you might as well
insertion sort as the base heuristic commonly has completely orthogonal inputs.
If the inputs are related, then a post insertion table wide sort could be
appropriate.

For full scale sorting, use an algorithm that can be used in parallel. Merge
sort and quick sort are serial in that they end/start with a single thread doing
all the work, but some variants can work with multi-threading. For small
data-sets, there are special sorting network techniques that are faster than
better algorithms just because they fit the hardware better.

## Sorting for the platform

Always remember that in data oriented design you must consider the data before
all else.

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
