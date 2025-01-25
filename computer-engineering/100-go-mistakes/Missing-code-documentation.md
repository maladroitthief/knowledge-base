---
title: Missing code documentation
layout: idea
tags:
  - 100-go-mistakes
---

# Missing code documentation

Every exported element should be documented.

## Mistake

Having no documentation, or worse bad documentation

## Fix

Documentation should be complete, punctuated sentences and should describe the
intent, not the implementation.

Use the `Deprecated:` comment in documentation to indicate that this is
deprecated. This is result in an LSP warning if it is being used.

Constants and variables should convey purpose and content though content can be
just for internal purposes.

```go
// DefaultPermission is the default permission used by the store engine.
const DefaultPermission = 0o644 // Need read and write accesses.
```

Packages should also provide some indicator to their scope. Keep the first line
short and concise as it will appear in the godocs.

```go
// Package math provides basic constants and mathematical functions.
//
// This package does not guarantee bit-identical results
// across architectures.
package math
```

Comments not adjacent to any declaration will be omitted. The first four lines
of this comment will not be included in the documentation.

```go
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
// Package math provides basic constants and mathematical functions.
//
// This package does not guarantee bit-identical results
// across architectures.
package math
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
