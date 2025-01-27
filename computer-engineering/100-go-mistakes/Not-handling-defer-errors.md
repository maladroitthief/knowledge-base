---
title: Not handling defer errors
layout: idea
tags:
  - 100-go-mistakes
---

# Not handling defer errors

## Mistake

Ignoring errors when using the defer keyword

```go
type Closer interface {
  Close() error
}

func getBalance(db *sql.DB, clientID string) (float32, error) {
  rows, err := db.Query(query, clientID)

  if err != nil {
    return 0, err
  }

  // if this errors, it will not be reported
  defer rows.Close()

  // ...
}
```

## Fix

Use some defer technique to ensure that the error is handled or acknowledged in
some way.

```go
type Closer interface {
  Close() error
}

func getBalance(db *sql.DB, clientID string) (float32, error) {
  rows, err := db.Query(query, clientID)

  if err != nil {
    return 0, err
  }

  defer func(){
    err := rows.Close()
    if err != nil {
      log.Printf("failed to close: %v", err)
    }
  }

  // ...
}

```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
