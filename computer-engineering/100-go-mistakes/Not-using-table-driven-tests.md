---
title: Not using table driven tests
layout: idea
tags:
  - 100-go-mistakes
---

# Not using table driven tests

## Mistake

```go
func removeNewLineSuffixes(s string string{
  if s == "" {
    return s
  }

  if strings.HasSuffix(s, "\r\n") {
    return removeNewLineSuffixes(s[:len(s)-2])
  }

  if strings.HasSuffix(s, "\n") {
    return removeNewLineSuffixes(s[:len(s)-1])
  }

  return s
}

func TestRemoveNewLineSuffix_Empty(t *testing.T) {
  got := removeNewLineSuffixes("")
  expected := ""
  if got != expected {
    t.Errorf("got: %s", got)
  }
}

func TestRemoveLineSuffixes_CRNL(t *testing.T) {
  got := removeNewLineSuffixes("a\r\n")
  expected := "a"
  if got != expected {
    t.Errorf("got: %s", got)
  }
}

func TestRemoveLineSuffixes_NL(t *testing.T) {
  got := removeNewLineSuffixes("a\n")
  expected := "a"
  if got != expected {
    t.Errorf("got: %s", got)
  }
}
```

## Fix

```go
func TestRemoveNewLineSuffix(t *testing.T) {
  tests := map[string]struct{
    input string
    want string
  }{
    "empty": {
      input: "",
      want: "",
    },
    "crnl": {
      input: "a\r\n",
      want: "a",
    },
    "nl": {
      input: "a\n",
      want: "a",
    },
  }

  for name, tt := range tests {
    t.Run(name, func(t *testing.T) {
      got := removeNewLineSuffixes(tt.input)
      if got != tt.want {
        t.Errorf("got: %s, want: %s", got, tt.want)
      }
    })
  }
}
```

We can also make these sub-tests run in parallel

```go
// ...

for name, tt := range tests {
  // must shadow loop variables
  tt := tt
  t.Run(name, func(t *testing.T){
    t.Parallel()
    // ...
  })
}

```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
