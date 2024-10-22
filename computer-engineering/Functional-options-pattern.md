---
title: Functional options pattern
layout: idea
tags:
  - design-patterns
---

# Functional options pattern

Using closures to build up optional parameters.

## Example

```go
type (
  options struct {
    port *int
  }

  Option func(*options) error
)

func WithPort(port int) Option {
  return func(options *options) error {
    if port < 0 {
      return errors.New("port less than zero")
    }

    options.port = &port
    return nil
  }
}

func NewServer(add string, opts ...Option) (*http.Server, error){
  var options options
  for _, opt := range opts {
    err := opt(&options)
    if err != nil {
      return nil, err
    }
  }
  // remaining implementation
}
```

## References

- [100-go-mistakes-and-how-to-avoid-them](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
