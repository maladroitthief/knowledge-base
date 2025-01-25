---
title: Unnecessary Nested Code
layout: idea
tags:
  - 100-go-mistakes
---

# Unnecessary nested code

Multiple layers of nested code can impact readability.

## Mistake

In this case, the client looks as if it is being assigned, but it is just the
shadow variable that is being set.

```go
func join(s1, s2 string, max int) (string, error) {
	if s1 == "" {
		return "", errors.New("s1 is empty")
	} else {
		if s2 == "" {
			return "", errors.New("s2 is empty")
		} else {
			// Calls a concatenate function to perform some specific concatenation but may return errors
			concat, err := concatenate(s1, s2)
			if err != nil {
				return "", err
			} else {
				if len(concat) > max {
					return concat[:max], nil
				} else {
					return concat, nil
				}
			}
		}
	}
}
```

## Fix

Same functionality, but easier to follow

```go
func join(s1, s2 string, max int) (string, error) {
	if s1 == "" {
		return "", errors.New("s1 is empty")
	}
	if s2 == "" {
		return "", errors.New("s2 is empty")
	}
	concat, err := concatenate(s1, s2)
	if err != nil {
		return "", err
	}
	if len(concat) > max {
		return concat[:max], nil
	}
	return concat, nil
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
