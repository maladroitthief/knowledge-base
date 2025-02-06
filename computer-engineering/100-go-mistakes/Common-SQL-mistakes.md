---
title: Common SQL mistakes
layout: idea
tags:
  - 100-go-mistakes
---

# Common SQL mistakes

## sql.Open

### Mistake

This does not always open the connection, it merely prepares it for later use.

```go
db, err := sql.Open("mysql", dsn)
if err != nil {
  return err
}
```

### Fix

```go
db, err := sql.Open("mysql", dsn)
if err != nil {
  return err
}

err = db.Ping()
if err != nil {
  return err
}
```

## Connection pooling

`sql.Open` doesn't return a single connection, but a pool of connections. We can
modify how this pool behaves with the following methods:

- SetMaxOpenConns()
- SetMaxIdleConns()
- SetConnMaxIdleTime()
- SetConnMaxLifetime()

## Not using prepared statements

A prepared statement is a feature most SQL databases implement to execute a
repeated SQL statement. This is in the interest of efficiency as well as it
reduces the risk of SQL injections.

```go
statement, err := db.Prepare("SELECT * FROM order WHERE ID = ?")
if err != nil {
  return err
}

rows, err := statement.Query(id)
```

## Mishandling null values

### Mistake

```go
rows, err := db.Query("SELECT dept, age FROM emp WHERE id = ?", id)
if err != nil {
  return err
}

var (
  // this is problematic if dept can be NULL
  department string
  age int
)

for rows.Next() {
  err := rows.Scan(&department, &age)
  if err != nil {
    return err
  }
}
```

### Fix

```go
rows, err := db.Query("SELECT dept, age FROM emp WHERE id = ?", id)
if err != nil {
  return err
}

var (
  department *string
  age int
)

for rows.Next() {
  err := rows.Scan(&department, &age)
  if err != nil {
    return err
  }
}
```

## Not handling row iteration errors

### Mistake

```go
func get(ctx context.Context, db *sql.DB, id string) (string, int, error) {
  rows, err := db.QueryContext(
    ctx,
    "SELECT dep, age FROM emp WHERE id = ?",
    id,
  )
  if err != nil {
    return "", 0, err
  }
  defer func(){
    err := rows.Close()
    if err != nil {
      // log this
    }
  }()

  var (
    department string
    age int
  )

  for rows.Next() {
    err := rows.Scan(&department, &age)
    if err != nil {
      return "", 0, err
    }
  }

  // we are missing the case if row.Next() fails for whatever reason

  return department, age, nil
}
```

### Fix

```go
func get(ctx context.Context, db *sql.DB, id string) (string, int, error) {
  rows, err := db.QueryContext(
    ctx,
    "SELECT dep, age FROM emp WHERE id = ?",
    id,
  )
  if err != nil {
    return "", 0, err
  }
  defer func(){
    err := rows.Close()
    if err != nil {
      // log this
    }
  }()

  var (
    department string
    age int
  )

  for rows.Next() {
    err := rows.Scan(&department, &age)
    if err != nil {
      return "", 0, err
    }
  }

  err = rows.Err()
  if err != nil {
    return "", 0, err
  }

  return department, age, nil
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
