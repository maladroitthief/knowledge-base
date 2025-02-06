---
title: Using the default HTTP client and server
layout: idea
tags:
  - 100-go-mistakes
---

# Using the default HTTP client and server

## Client

### Mistake

This does not specify any timeouts

```go
client := &http.Client{}
```

### Fix

```go
client := &http.Client{
  Timeout: 5 * time.Second,
  Transport: &http.Transport{
    DialContext: (&net.Dialer{
      Timeout: time.Second,
    }).DialContext,
    TLSHandshakeTimeout: time.Second,
    ResponseHeaderTimeout: time.Second,
  },
}
```

We should also consider that the clients are pooled and re-used. Balancing these
variables is critical for production facing systems.

- http.Transport.IdleConnTimeout (default 90s): this is how long idle
  connections hang around before closed
- http.Transport.MaxIdleConns (default 100): the max idle connections
- http.Transport.MaxIdleConnsPerHost (default 2): max idle connections per host

## Server

### Mistake

```go
server := &http.Server{}
server.Serve(listener)
```

### Fix

```go
server := &http.Server{
  Addr: ":8080",
  ReadHeaderTimeout: 500 * time.Millisecond,
  ReadTimeout: 500 * time.Millisecond,
  Handler: http.TimeoutHandler(handler, time.Second, "foo"),
  IdleTimeout: time.Second,
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
