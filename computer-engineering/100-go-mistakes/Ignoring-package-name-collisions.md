---
title: Ignoring package name collisions
layout: idea
tags:
  - 100-go-mistakes
---

# Ignoring package name collisions

Package name collisions occur when a variable or function shares the same name
as a package.

## Mistake

Package declaration

```go
package redis

type Client struct {
	//...
}

func NewClient() *Client {
	//...
}

func (c *Client) Get(key string) (string, error) {
	// ...
}
```

Client implementation

```go
redis := redis.NewClient()
v, err := redis.Get("foo")
```

The redis variable now makes the redis package inaccessible in this scope

## Fix

Use an import alias or change the variable name.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
