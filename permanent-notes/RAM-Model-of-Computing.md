---
tags:
 - idea
aliases:
---

# RAM Model of Computing

The RAM Model of Computation is a model for measuring time by counting the number of steps an algorithm must take to complete. There are some assumptions made in the RAM Model such as:

- All simple operations are considered to be 1 step
- Loops and subroutines count for N steps with N being the number of iterations
- Memory access takes 1 step

Another crucial part of the RAM Model is analyzing algorithms in multiple scenarios. The RAM Model considers:

- **Worst case complexity**: *O(g(n))* The maximum number of steps to complete. This is [Big-Oh-Notation](Big-Oh-Notation.md)
- **Best case complexity**: *Ω(g(n))* The minimum number of steps to complete
- **Average case complexity**: *ϴ(g(n))* The average number of steps over all instances. This is also known as expected time

## References

- [Algorithms](Algorithms.md)
- [The-Algorithm-Design-Manual](The-Algorithm-Design-Manual.md)
