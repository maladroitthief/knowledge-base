---
title: Searching
layout: idea
tags:
  - data-oriented-design
---

# Searching

The greatest performance gain for searching is not having to search. If the
search is unnecessary then it should be avoided. Search helpers like binary
trees, hash tables, or keeping data sorted can also aid in finding rows in
tables.

## Indexes

The concept of an index has been around for a long time in the RDMS world. In
the SQL world, learning whether a record exists would involve building a query.
This query could start out simple, but overtime could become more complex
depending on what data is needed. Even more complex is a query that can hook
into the insertion, update, or delete operations for a table to that it could
update it's results without needing to re-run the full query.

Building generalized systems to mirror this behavior offers multiple benefits.
This could provide insight on what indexes are no longer in use and enable the
application to self-document and profile. It could also provide optics on data
hot-spots where there is room for improvement.

## Data oriented lookup

The first step for approaching searching is to identify the difference between
search criteria and the data dependencies of that criteria. A naive approach
would be to query an object for this information, but this is wasteful. This
would require code to support this query, indirect memory accesses, and a lot of
noise on the cache line that ends up going to waste.

```go
type FullAnimKey struct {
  Time        float32
  Translation Vec3
  Scale       Vec3
  Rotation    Vec4
}

type FullAnim struct {
  Numkeys int
  Keys    []FullAnimKey
}

// binary search for key frame
func (fa *FullAnim) GetKeyAtTimeBinary(t float32) FullAnimKey {
  low := 0
  high := fa.Numkeys - 1
  mid := (low + high) / 2

  for low < high {
    if t < fa.Keys[mid].Time {
      high = mid - 1
    } else {
      low = mid
    }

    mid = (low + high + 1) / 2
  }

  return fa.Keys[mid]
}
```

This can be improved by understanding the data needs of the producer and
consumer for this query. By using a partial struct of arrays approach, we can
avoid a lot of memory requests that would have been wasted.

```go
type DataOnlyAnimKey struct {
  Translation Vec3
  Scale       Vec3
  Rotation    Vec4
}

type DataOnlyAnim struct {
  Numkeys int
  KeyTime []*float32
  Keys    []*FullAnimKey
}

// binary search for key frame
func (fa *FullAnim) GetKeyAtTimeBinary(t float32) *FullAnimKey {
  low := 0
  high := fa.Numkeys - 1
  mid := (low + high) / 2

  for low < high {
    if t < fa.KeyTime[mid] {
      high = mid - 1
    } else {
      low = mid
    }

    mid = (low + high + 1) / 2
  }

  return fa.Keys[mid]
}
```

This is faster of most hardware we are only packing the cache line with data we
care about so we can fit more results in a single cache line. Depending on the
processor, this small change could mean that instead of being able to fit only
one key per cache line, we can now fit 16 keys.

This code can be further optimized, but it would involve making some trade-offs.
Binary search will zero in on the correct key, but each of the first steps will
require a new cache-line read. If it is already known how large the cache line
is, we can check all the values in that cache line that have been already loaded
while we wait for the next cache line to load.

Also, binary search is optimized around reducing the number of instructions, not
around being fast. Loading a full cache line of data and utilizing it fully is
more helpful than using the smallest number of instructions. Reconsidering the
data layout for an algorithm could provide more of an impact than what algorithm
was chosen.

## Finding the lowest/highest is a sorting problem

Often times searching is not necessary. If we need to find something closest to
an entity it is often more effective to keep a list of those entities. Initial
queries may run the real search to populate that list, but if searching is so
frequent then it should be promoted to doing an in-place update of another
tables data.

## Finding random is a hash/tree issue

If a table is being represented as a tree, rather than rebalance on every
modification, process all of the modifications in one stage, rebalance the tree,
and then handle all reads after that. A B Tree has much wider nodes so it is
shallower than most map implementations.

Hash tables are more appropriate when there are many modifications interspersed
with look ups. Trees are more appropriate when data is mostly static and
unchanging between reads.

When data is constant a perfect hash is better than a tree.

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
