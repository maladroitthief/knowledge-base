---
title: Not closing transient resources
layout: idea
tags:
  - 100-go-mistakes
---

# Not closing transient resources

## Mistake

### HTTP body

```go
type handler struct {
  client http.Client
  url string
}

func (h handler) getBody() (string, error) {
  // resp leaks here
  resp, err := h.client.Get(h.url)
  if err != nil {
    return "", err
  }

  body, err := io.ReadAll(resp.Body)
  if err != nil {
    return "", err
  }

  return string(body), nil
}
```

### sql.Rows

```go
// rows leaks here keeping an open connection
rows, err := db.Query("SELECT * FROM customers")
if err != nil {
  return err
}

// ...

return nil
```

### os.File

This is fine for reading from a file, but for writing we want to capture any
errors that may occur on the file close.

```go
f, err := os.OpenFile(filename, os.O_APPEND|os.O_WRONLY, os.ModeAppend)
if err != nil {
  return err
}

defer func(){
  err := f.Close()
  if err != nil {
    // log
  }
}()
```

## Fix

### HTTP body

```go
type handler struct {
  client http.Client
  url string
}

func (h handler) getBody() (string, error) {
  resp, err := h.client.Get(h.url)
  if err != nil {
    return "", err
  }

  defer func(){
    err := resp.Body.Close()
    if err != nil {
      // log
    }
  }()

  body, err := io.ReadAll(resp.Body)
  if err != nil {
    return "", err
  }

  return string(body), nil
}
```

### sql.Rows

```go
rows, err := db.Query("SELECT * FROM customers")
if err != nil {
  return err
}

defer func(){
  err := rows.Close()
  if err != nil {
    // log
  }
}()
// ...

return nil
```

### os.File

```go
func writeToFile(filename string, content []byte) (err error) {
  f, err := os.OpenFile(filename, os.O_APPEND|os.O_WRONLY, os.ModeAppend)
  if err != nil {
    return err
  }

  defer func(){
    closeError := f.Close()
    if err != nil {
      // if we encountered no other errors, we capture the named return
      //   parameter and set it equal to any closing errors
      err == closeErr
    }
  }()

  return
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
