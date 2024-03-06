---
tags:
  - idea
aliases:
---

# Go project layout

The go community standard layout.

- /cmd => Main source code. Example: `/cmd/foo/main.go`
- /internal => Private code that should not be exported
- /pkg => Public code to be exported
- /test => Additional external tests and data. Unit test should not be here
- /configs => Configuration files
- /docs => Design and user documents
- /examples => Example use cases for the application/API
- /api => API contract files (Protocol buffers, Swagger, ...)
- /web => Web application files (static files, assets, ...)
- /build => Packaging and continuous integration files
- /scripts => Scripts for analysis, installation, etc
- /vendor => Application dependencies

## References

- [[100-go-mistakes-and-how-to-avoid-them]]
