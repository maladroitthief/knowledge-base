---
title: Not taking into account instruction-level parallelism
layout: idea
tags:
  - 100-go-mistakes
---

# Not taking into account instruction-level parallelism

Instruction level parallelism (ILP) is performance optimization that allows the
parallelization of a sequence of instructions. Instead of being a sum of the
instructions total execution time, our total time is just the length of
whichever instruction took the longest to execute.

This can be incredibly beneficial, but it can lead to hazards. If one of the
instructions is dependent on another parallel instruction, like a conditional
operation, this is called a **control/branching hazard**. CPU designers solved
this problem using **branch prediction**. Using internal metrics, the CPU can
make a best guess at what the most likely branching path will be. In the event
that the CPU guesses incorrectly, the CPU will flush the current execution
pipeline to ensure there are no inconsistencies leading to a performance penalty
of ~10-20 cycles.

Data hazards should also be considered. Consider the following:

```asm
// write A and B to register C
ADD C, A, B
// write C and D to register D
ADD D, C, D
```

The second instruction in this case is dependent on the first setting register
C. To avoid this, CPU designers began using a trick call **forwarding** to
bypass writing to a register.

## Mistake

```go
const n = 1_000_000

func add(s [2]int64) [2]int64 {
  for i := 0; i < n; i++ {
    s[0]++ // data hazard
    if s[0]%2 == 0 { // control hazard
      s[1]++ // data hazard
    }
  }

  return s
}
```

## Fix

```go
const n = 1_000_000

func add(s [2]int64) [2]int64 {
  for i:=0; i < n; i++ {
    v := s[0] // removes the data hazard from the increment
    s[0] = v + 1 // this can now be run in parallel by the CPU

    // removes the control hazard by checking the variable instead of the array
    if v%2 != 0 { // this can now be run in parallel by the CPU
      s[1]++
    }
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
