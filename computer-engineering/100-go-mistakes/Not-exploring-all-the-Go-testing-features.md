---
title: Not exploring all the Go test features
layout: idea
tags:
  - 100-go-mistakes
---

# Not exploring all the Go test features

## Code coverage

```shell
go test -coverpkg=./... -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

## Black box testing

```go
package counter
```

```go
package counter_test
```

## Utility functions

```go
func TestCustomer(t *testing.T) {
  customer := createCustomer(t, "foo")
  // ...
}

func createCustomer(t *testing.T, name string) Customer {
  // ...
  if err != nil {
    t.Fatal(err)
  }

  return customer
}
```

## Setup and tear-down

### Per function

```go
func TestMySQLIntegration(t *testing.T) {
  // ...
  db := createConnection(t, "tcp(localhost:3306)/db")
  // ...
}

func createConnection(t *testing.T, dsn string) *sql.DB {
  db, err := sql.Open("mysql", dsn)
  if err != nil {
    t.FailNow()
  }

  t.Cleanup(
    func() {
      _ = db.Close()
    }
  )

  return db
}
```

### Per package

```go
func TestMain(m *testing.Main) {
  setupMySQL()
  code := m.Run()
  teardownMySQL()
  os.Exit(code)
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
