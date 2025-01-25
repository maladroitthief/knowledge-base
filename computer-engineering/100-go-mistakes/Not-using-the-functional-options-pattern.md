---
title: Not using the functional options pattern
layout: idea
tags:
  - 100-go-mistakes
---

# Not using the functional options pattern

For API design, how do we handle optional configurations?

## Mistake

Using struct parameters or complicated builders to handle optional
configurations.

```go
type Config struct {
	Port int
}

func NewServer(addr string, cfg Config) {
	// ...
}

// Initializes Port to 0
c1 := httplib.Config{
	Port: 0,
}

// Port is missing, so it’s initialized to 0.
c2 := httplib.Config{
}
```

## Fix

Leverage closures and variadic arguments

```go
type options struct {
	port *int // we make this a pointer so that it can be nil
}

// A function type that updates the options struct
type Option func(options *options) error

func WithPort(port int) Option {
	return func(options *options) error {
		if port < 0 {
			return errors.New("port should be positive")
		}

		options.port = &port

		return nil
	}
}

// Accepts many option closures
func NewServer(addr string, opts ...Option) (*http.Server, error) {
	// we create the options struct that the closures reference
	var options options

	for _, opt := range opts {
		err := opt(&options)
		if err != nil {
			return nil, err
		}
	}

	// At this stage, the options struct is built and contains the config
	// Therefore, we can implement our logic related to port configuration
	var port int
	if options.port == nil {
		port = defaultHTTPPort
	} else {
		if *options.port == 0 {
			port = randomPort()
		} else {
			port = *options.port
		}
	}
	// ...
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
