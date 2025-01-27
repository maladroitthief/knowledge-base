---
title: Not handling an error
layout: idea
tags:
  - 100-go-mistakes
---

# Not handling an error


## Mistake

Completely omitting the error.

```go
notify()
```

## Fix

Acknowledging that an error was returned, but we are ignoring it.

```go
_ = notify()
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
