package main

import (
	"errors"
	"net/http"
)

type options struct {
	port *int
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
