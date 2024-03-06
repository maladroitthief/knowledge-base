---
tags:
  - idea
aliases:
---

# Builder pattern

Constructing objects using a separate builder object.

## Example

```go
type (
  Config struct {
    Port int
  }

  ConfigBuilder struct {
    port *int
  }
)

func (cb *ConfigBuilder) Port(port int) *ConfigBuilder {
  cb.port = &port
  return cb
}

func (cb *ConfigBuilder) Build() Config {
  c := Config{}
  if cb.port == nil {
    c.Port = defaultHTTPPort
  } else {
    c.Port = *cb.port
  }
}
```

## References

- [[100-go-mistakes-and-how-to-avoid-them]]
