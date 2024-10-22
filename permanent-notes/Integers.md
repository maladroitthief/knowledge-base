---
tags:
  - idea
aliases:
---

# Integer literals

Integer literals are numbered values that do not have a fractional component or
an exponent.

## Representation

Integer literals can be represented in many different forms for convenience. The
more common forms are as follows:

```go
// These are different representations of the same literal
binary := 0b1101
decimal := 13
octal := 0o15
hexadecimal := 0x0d
```

## Two's complement

For signed integer literals, two's complement is an efficient method for storing
positive and negative values.

- Left-most bit denotes the sign. (0 is positive, 1 is negative)
- Positive values are expressed in typical binary form
- Negative values are expressed in binary with the bits inverted + 1

This allows for very easy addition and subtraction operations for the processor.
As an added benefit, there is also only one way to represent 0 rather than
potentially having a positive and negative 0.

```go
// 00000100
var positive int8 = 4
// 11111100
var negative int8 = -4
```

## Overflow

Integer overflow occurs when a signed or unsigned integer literal is used to
store a value too large for it's size. This can happen at run time or compile
time and can result in unexpected behavior.

### Addition

To catch overflow from addition operations use the following check:

```go
func addInt(a, b int) int {
  if a > math.MaxInt-b {
    panic()
  }

  return a + b
}
```

### Multiplication

To catch overflow from multiplication, more steps need to be followed:

```go
func multInt(a, b int) int {
  if a == 0 || b == 0 {
    return 0
  }

  result := a * b

  if a == 1 || b == 1 {
    return result
  }

  if a == math.MinInt || b == math.MinInt {
    panic()
  }

  if result / b != a {
    panic()
  }

  return result
}
```

## References

- [[100-go-mistakes-and-how-to-avoid-them]]
