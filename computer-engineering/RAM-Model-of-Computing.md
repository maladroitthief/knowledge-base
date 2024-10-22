---
title: RAM Model of Computing
layout: idea
tags:
  - algorithms
---

# RAM Model of Computing

The RAM Model of Computation is a model for measuring time by counting the
number of steps an algorithm must take to complete. There are some assumptions
made in the RAM Model such as:

- All simple operations are considered to be 1 step
- Loops and subroutines count for N steps with N being the number of iterations
- Memory access takes 1 step

Another crucial part of the RAM Model is analyzing algorithms in multiple
scenarios. The RAM Model considers:

- **Worst case complexity**: _O(g(n))_ The maximum number of steps to complete
- **Best case complexity**: _Ω(g(n))_ The minimum number of steps to complete
- **Average case complexity**: _ϴ(g(n))_ The average number of steps over all
  instances

## References

- [The-Algorithm-Design-Manual](/reference/The-Algorithm-Design-Manual)
