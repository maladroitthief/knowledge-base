---
title: Not understanding floating points
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding floating points

The concept of floating point numbers was created to solve the problem that
integer values cannot represent fractional numbers. Floating point numbers are
an approximation of real numbers due to the fact that their is an infinite
number of fractions between two integers.

## Mistake

Failing to understand the lack of precision with floating point numbers. Using
conditional comparisons like `==` can result in unexpected behavior.

## Fix

- When comparing floating point numbers, check that the difference is within an
  acceptable range
- When performing additions or subtractions, group operations with a similar
  order of magnitude for better accuracy.
- to favor accuracy, if a sequence of operations requires addition, subtraction,
  multiplication, or division, perform the multiplication and division
  operations first.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
