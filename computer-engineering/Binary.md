---
title: Binary
layout: idea
tags:
  - computer-engineering
---

# Binary

Binary is a base 2 number system that is used in machine code. It can be handy
at times to transform data to binary or to preform bit-wise operations.

## Corner cases

- Negative numbers
- Overflow/underflow errors

## Bit-wise operations

### Check if k'th bit is set

```go
var num uint
num & (1 << k) != 0
```

### Set the k'th bit

```go
var num uint
num |= (1 << k)
```

### Clear the k'th bit

```go
var num uint
num &= ^(1 << k)
```

### Toggle the k'th bit

```go
var num uint
num ^= (1 << k)
```

### Multiply by 2^k

```go
var num uint
num << k
```

### Divide by 2^k

```go
var num uint
num >> k
```

### Check if power of 2

```go
var num uint
(num & (num - 1)) == 0
```

### Swap two variables

```go
var num1 uint
var num2 uint
num1 ^= num2
num2 ^= num1
num1 ^= num2
```

## References

- [Tech-Interview-Handbook](/reference/Tech-Interview-Handbook)
