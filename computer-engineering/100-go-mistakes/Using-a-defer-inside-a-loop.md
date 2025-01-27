---
title: Using a defer inside a loop
layout: idea
tags:
  - 100-go-mistakes
---

# Using a defer inside a loop

The `defer` statement delays execution until the surrounding function exits.

## Mistake

These files could potentially be kept open forever, causing a leak.

```go
func readFiles(ch <-chan string) error {
	for path := range ch {
		file, err := os.Open(path)

		if err != nil {
			return err
		}

		// This is deferred when readFiles exits, not the current iteration
		defer file.Close()
	}

	return nil
}
```

## Fix

Change the function scope

```go
func readFiles(ch <-chan string) error {
	for path := range ch {
    readFile(path)
	}

	return nil
}

func readFile(path string) error {
  file, err := os.Open(path)

  if err != nil {
    return err
  }

  defer file.Close()
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
