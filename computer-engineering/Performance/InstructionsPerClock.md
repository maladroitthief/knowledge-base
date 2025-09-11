---
title: Instructions per clock
layout: idea
tags:
  - performance
  - computer-engineering
---

# Instructions per clock

Even if we reduce our code down to only producing the instructions we need,
there is still a lot of variables that can determine how fast a CPU can perform
those instructions. Modern CPUs can have many instructions that all accomplish
the same tasks, but in different ways. To compare these instructions, we use
metrics like instructions per clock (IPC) and instruction level parallelism
(IPL). These both roughly equate to how many instructions the CPU can execute
every clock cycle.

## For loops

Consider the following loop.

```c
for i = 0; i < count; i += 1 {
  sum += input[i];
}
```

Let's break this down into the minimum amount of instructions required just to
perform this loop.

- `input[i]` must be loaded from memory
- `i += 1` an addition
- `i < count` requires a comparison
- `sum += input[1]` the actual work, an addition

The overhead of this loop alone is at least 3 instructions with the actual work
the loop is trying to accomplish pushing it up to 4 instructions. Rather than
remove instructions, we can try to do more work in the loop to reduce the
overhead penalty. This is referred to as unrolling the loop.

```c
//
// No Unroll: 0.8 IPC
//
for i = 0; i < count; i += 1 {
  sum += input[i];
}

//
// Unroll to 2: 0.994 IPC
//
for i = 0; i < count; i += 2 {
  sum += input[i];
  sum += input[i+1];
}
//
// Unroll to 4: 0.994 IPC
//
for i = 0; i < count; i += 4 {
  sum += input[i];
  sum += input[i+1];
  sum += input[i+2];
  sum += input[i+3];
}
```

## What are we asking the CPU to do?

CPUs will look for instructions that can be executed at the same time. Since the
loop overhead is not dependent on the work we are doing, they can be executed in
parallel.

```asm
// These two instructions can be executed in parallel, no dependency
ADD A, INPUT[i]
CMP i, count
```

However, the way we have written our code results in a series of additions.
Since each of these ADDs depend on the sum of the previous instruction, we
cannot do this work in parallel. This is referred to as a **serial dependency
chain**.

```asm
ADD A, INPUT[i]
ADD A, INPUT[i+1]
ADD A, INPUT[i+2]
```

The only way to improve the performance is to break the serial dependency chain
so the CPU can add these numbers in parallel. We can do this by adding these
numbers in pairs.

```c
//
// Dual scalar: 1.27 IPC
//
for i = 0; i < count; i += 2 {
  sumA += input[i];
  sumB += input[i+1];
}
sum = sumA + sumB;

//
// Quad scalar: 1.70 IPC
//
for i = 0; i < count; i += 4 {
  sumA += input[i];
  sumB += input[i+1];
  sumC += input[i+2];
  sumD += input[i+3];
}
sum = sumA + sumB + sumC + sumD;

//
// Quad scalar pointer: 1.95 IPC
//   - Removes some loop overhead
//
count /= 4;
while count-- {
  sumA += input[0];
  sumB += input[1];
  sumC += input[2];
  sumD += input[3];
  &input += 4
}
sum = sumA + sumB + sumC + sumD;
```
