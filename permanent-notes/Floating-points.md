---
tags:
  - idea
aliases:
  - decimal
---

# Floating points

The concept of floating point numbers was created to solve the problem that
integer values cannot represent fractional numbers. Floating point numbers are
an approximation of real numbers due to the fact that their is an infinite
number of fractions between two integers.

## IEEE-754

The IEEE-754 standard for floats is that some bits represent a mantissa and
other bits represent an exponent that is applied as a multiplier to the
mantissa.

In single-precision floating point (32 bits), 8 bits represent the exponent and
23 bits represent the mantissa. In double-precision floating point (64 bits), 11
bits represent the exponent and 52 bits represent the mantissa. The remaining
bit is for the sign.

$$ sign*2^{exponent}*mantissa $$

### Special numbers

Additionally, positive infinity, negative infinity, and not a number can all be
considered special cases for floating points.

```go
var a float64

positiveInfinity := 1/a
negativeInfinity := -1/a
notANumber := a/a
```

## References

- [[100-go-mistakes-and-how-to-avoid-them]]
