---
title: Not understanding stack vs heap
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding stack vs heap

## Stack

The stack is the default memory, a last in; first out (LIFO) data structure that
stores all the local variables for a specific goroutine. When a goroutine is
started it gets 2KB of contiguous memory as it's stack space that can
grow/shrink at run-time. Moving between different functions creates a new stack
frame and allocates any variables necessary in that scope. Variables outside of
the stack frame still exist, but cannot be referenced in the new frame without
using a pointer.

## Heap

When we do need to reference variables in other stack frames, we need to
leverage the heap. A memory heap is a pool of memory shared by all goroutines.
When a variable can no longer live on the stack, it is **escaped** to the heap.

## Performance concerns

The stack is self-cleaning and is only accessed by one goroutine. The heap,
however, needs to be maintained by the garbage collector, GC. The more heap
allocations that are made, the more we pressure the GC. When the GC runs, it
used 25% of the available CPU capacity and can introduce milliseconds of "stop
the world" latency by pausing the application. Allocating on the stack is also
trivial for a goroutine as compared to the heap.

## Escape analysis

Escape analysis refers to the work performed by the compiler to decide whether a
variable should be allocated on the stack or heap. When an allocation cannot
happen on the stack, it happens on the heap. A function returning a pointer by
**sharing up**, the compiler cannot reason whether that variable is being
referenced after that function returns. In that case, the variable is allocated
to the heap. Conversely, if a pointer is passed to a function parameter by
**sharing down**, the compiler can reason with the fact that the variable will
no longer be reference. Therefore it is allocated to the stack.

The following cases are also allocated to the heap:

- Global variables
- Pointer sent to channel
- Variable referenced by value sent to channel
- Variable too large for the stack
- Variable of unknown size
- Slice where the backing array needs reallocated because of **append**

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
