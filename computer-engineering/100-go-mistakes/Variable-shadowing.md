---
title: Variable shadowing
layout: idea
tags:
  - 100-go-mistakes
---

# Variable-shadowing

Variable shadowing is re-declaring a variable in an inner block and can result
in unexpected outcomes.

## Mistake

In this case, the client looks as if it is being assigned, but it is just the
shadow variable that is being set.

```go
var client *http.Client
if tracing {
    // Shadowed client
	client, err := NewTracingClient()
	if err != nil {
	    return err
	}
} else {
    // Shadowed client
	client, err := NewClient()
	if err != nil {
	    return err
	}
}
// Client is still nil at this point
```

## Fix

In this case, a temporary variable is being declared and then is assigned to the
client

```go
var client *http.Client
if tracing {
	c, err := NewTracingClient()
	if err != nil {
	    return err
	}
    client = c
} else {
	c, err := NewClient()
	if err != nil {
	    return err
	}
    client = c
}
```

It also makes sense to avoid declaring the error inside the conditional scope.

```go
var client *http.Client
var err error
if tracing {
	c, err = NewTracingClient()
} else {
	c, err = NewClient()
}

if err != nil {
    return err
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
