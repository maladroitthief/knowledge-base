---
title: Overusing getters and setters
layout: idea
tags:
  - 100-go-mistakes
---

# Overusing getters and setters

Data encapsulation refers to hiding the values and state of an object. Getters
and Setters are a means to enable encapsulation, yet Go has no automatic support
for getters or setters.

## Mistake

Providing a getter/setter for all struct attributes when it clearly is not
necessary.

## Fix

Use getters/setters for the following use cases:

- Encapsulating behavior for a field (validation, calculated value)
- Hiding internal representation (this should rarely be considered)
- Aid in debugging

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
