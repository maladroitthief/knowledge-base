---
title: Interface on the producer side
layout: idea
tags:
  - 100-go-mistakes
---

# Interface on the producer side

Deciding where to implement an interface is a pretty common mistake. An
interface defined in the same package as the concrete implementation is referred
to as the **Producer Side**. The **Consumer Side** is considered to be an
interface defined in some external package where it is being used.

## Mistake

Creating an interface on the producer side. Interfaces are satisfied implicitly
in Go and because of this we should be trying to discover the abstraction, not
create it. Creating an interface on the producer side means the producer is
creating the abstraction for all it's consumers.

## Fix

The client/consumer should be where the interface is created and should also be
the decider if an interface is needed at all.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
