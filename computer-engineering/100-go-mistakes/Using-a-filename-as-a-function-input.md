---
title: Using a filename as a function input
layout: idea
tags:
  - 100-go-mistakes
---

# Using a filename as a function input

## Mistake

Testing this function would require a unique file for every use case.

```go
func countEmptyLinesInFile(filename string) (int, error) {
  file, err := os.Open(filename)
  if err != nil {
    return 0, err
  }
  // Handle file closure
  scanner := bufio.NewScanner(file)
  for scanner.Scan() {
  // ...
  }
}
```

## Fix

Extract the file i/o from the function logic.

```go
func countEmptyLines(reader io.Reader) (int, error) {
  scanner := bufio.NewScanner(reader)
  for scanner.Scan() {
  // ...
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
