---
title: Not categorizing tests
layout: idea
tags:
  - 100-go-mistakes
---

# Not categorizing tests

## Build tags

```go
//go:build integration

package db_test
```

```shell
go test --tags=integration -v .
```

## Environment variables

This provides information to the user that this test was skipped

```go
func TestInsert(t *testing.T) {
  if os.Getenv("INTEGRATION") != true {
    t.Skip("skipping integration test")
  }
}
```

## Short mode

```go
func TestLongRunning(t *testing.T){
  if testing.Short() {
    t.Skip("skipping long running test")
  }
}
```

```shell
go test -short -v .
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
