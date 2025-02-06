---
title: Not understanding how the GC works
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding how the GC works

A GC keeps a tree of object references and the Go GC is based on the mark and
sweep algorithm.

- Mark stage: Traverse all objects on the heap and mark if they are in use
- Sweep stage: Traverse the tree of reference from the root and deallocate
  objects that are no longer referenced

When a GC runs, it first performs a set of actions that lead to **stopping the
world**. All available CPU time is used to perform the GC and the application is
put on hold until the GC is finished. The Go GC also includes a way to free
memory after consumption peak using a part of the GC called the **periodic
scavenger**. After some time, the GC will detect that a large heap is no longer
necessary and will free some of it to the OS. This can be done manually with
`debug.FreeOSMemory()`.

The GC cycle runs based on the environment variable `GOGC`. This variable is the
percent of heap growth since the last GC and defaults to 100%. The GC will also
run every 2 minutes if a GC hasn't happened recently.

Given a scenario where there is significant pressure on the GC due to large,
predictable traffic spikes, consider creating the following global variable in
`main.go`:

```go
var min = make([]byte, 1_000_000_000) // 1 GigaByte
```

This can greatly increase heap stability because in order for a GC to trigger we
would need to double the heap size to 2GB. This reduces the amount of GC cycles
improving latency. This is also not wasteful, but most OS make use of lazy
allocation implementations like `mmap()` that will reserve virtual memory, but
not physical memory.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
