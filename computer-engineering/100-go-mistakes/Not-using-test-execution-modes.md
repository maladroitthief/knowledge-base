---
title: Not using test execution modes
layout: idea
tags:
  - 100-go-mistakes
---

# Not using test execution modes

## Parallel

Parallel execution mode allows us to run specific tests in parallel. These tests
will run alongside other parallel tests. Any sequential tests will be executed
first.

```go
func TestFoo(t *testing.T){
  t.Parallel()
}
```

## Shuffle

Randomize the execution order.

```shell
go test -shuffle=on -v .
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
