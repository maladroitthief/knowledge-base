---
title: Returning a nil receiver
layout: idea
tags:
  - 100-go-mistakes
---

# Returning a nil receiver

## Mistake

Nil is a valid receiver in Go.

```go
type MultiError struct {
  errs []string
}

func (m *MultiError) Add(err error) {
  m.errs = append(m.errs, err.Error())
}

// Satisfying the error interface
func (m *MultiError) Error() string {
  return strings.Join(m.errs, ";")
}

func (c Customer) Validate() error {
  var m *MultiError

  if c.Age < 0 {
    m = &MultiError{}
    m.Add(errors.New("age is negative"))
  }

  if c.Name == "" {
    if m == nil {
      m = &MultiError{}
    }

    m.Add(errors.New("name is nil"))
  }

  // Even though m is nil, it is still a valid receiver.
  // This will always return as an error
  return m
}

```

## Fix

```go
func (c Customer) Validate() error {
  var m *MultiError

  if c.Age < 0 {
    m = &MultiError{}
    m.Add(errors.New("age is negative"))
  }

  if c.Name == "" {
    if m == nil {
      m = &MultiError{}
    }

    m.Add(errors.New("name is nil"))
  }

  return nil
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
