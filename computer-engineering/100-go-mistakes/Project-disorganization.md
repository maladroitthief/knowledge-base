---
title: Project disorganization
layout: idea
tags:
  - 100-go-mistakes
---

# Project disorganization

Organizing a project in Go can be challenging. There is no enforced structure or
schema which can lead to code bases that are difficult to navigate.

## Mistake

Having no plan on how a project should be organized.

## Fix

There a many solutions for how to layout a project that all depend on the use
case.

### Flat

For small projects it's usually fine to just have a flat layout. There is no
need to over-complicate things.

### Go community standard layout

Any project that intends to grow to substantial sizes and be used by multiple
engineers should adhere to the Go community standard layout.

- /cmd => Main source code. Example: `/cmd/foo/main.go`
- /internal => Private code that should not be exported
- /pkg => Public code to be exported
- /test => Additional external tests and data. Unit test should **not** be here
- /configs => Configuration files
- /docs => Design and user documents
- /examples => Example use cases for the application/API
- /api => API contract files (Protocol buffers, Swagger, ...)
- /web => Web application files (static files, assets, ...)
- /build => Packaging and continuous integration files
- /scripts => Scripts for analysis, installation, etc
- /vendor => Application dependencies

### Package organization

Packages are best to be organized by sub-directory. Consider the `net` package:

```yaml
net:
  http:
    client.go:
  smtp:
    auto.go:
  addrselect.go:
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
