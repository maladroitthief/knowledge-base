---
title: Optimizations
layout: idea
tags:
  - data-oriented-design
---

# Optimizations

Optimizations cannot be done blindly, you need to know what is causing the code
to run slowly. In most cases, data movement tends to be the most expensive
operation. Running algorithms or functions on data tends to be less expensive.
If you begin development by organizing your data into arrays, you open yourself
up to many opportunities for optimization. By having such an agnostic data
layout, any improvements made can be applied in many locations with little
concern for incompatibility.

To go even further, by using stateless transformations we can also be assured we
are not introducing unexpected side effects. Most projects suffer from not
thinking about optimization early enough, often claiming that premature
optimization is inherently bad. However, optimization late in project's life
cycle becomes nigh impossible with object instances existing everywhere, even
when they are not needed. A primary flaw with Object Oriented is the idea that
an instance an atomic unit of processing. This leads to assume that collections
of objects should be treated as collections of individuals.

This concept is true but it then directs all instructions to flow through the
object. This works at small scale, but when considering hundreds of individual
objects that now need to be processed as a sequence, things start to fall apart.
Objects tend to exist just to mirror how things exist in the real world rather
than existing for a reason. This leads to features being added that match some
real world relationship, rather than reason.

## When should we optimize?

Premature optimization is optimizing a solution without knowing whether it will
actually make a difference. Optimizing without using any data to prove that the
code is slow or is using too much memory is bad and premature. Without
profiling, even if the code is visually running slow and erratic, any changes
introduced are premature optimizations. This is engineering by story-telling,
not engineering by engineering.

The only way to avoid premature optimization is to look at data. Profile the
application and observe the results. Any improvements after this cannot be
premature, because they have been measured. Theses measurements can then be
evaluated in terms of failure, success, or progress.

Profiling should only start when you have metrics to work towards. When metrics
have been defined for signals such as latency, traffic, rate of errors, or
saturation it can be reasonable to begin profiling. Without having any metrics
for what is considered to be optimal, it is unreasonable to check the
performance of the code.

## Feedback

Not being aware that you are writing poorly optimized code hurts more than just
the application. Having no feedback, developers cannot improve their skills.
This leads to bad habits being reinforced and more bad code. Delayed feedback is
also bad because it leaves little opportunity to internalize it and build up
intuition. Adding metrics on the status of the codes performance will help with
this. Learning early that a technique or approach is slow helps remove the sunk
cost fallacy that can develop over time.

TODO: Finish the remaining chapter -ian

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
