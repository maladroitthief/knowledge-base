---
title: Interface
layout: idea
tags:
  - go
---

# interface

Interfaces in Go provide a way to specify the behavior of an object. These
abstractions are satisfied implicitly and do not need a keyword like
`implements` to use.

```go
type Reader interface {
  Read() []byte
}

func (io *JsonReader) Read() []byte {
  // ...
}
```

## When to use

While not an exhaustive list, these are some of the most common cases for making
use of interfaces.

### Common behavior

Defining common behavior that multiple types of objects need to define. A good
example of this would be sorting.

```go
type Sortable interface {
  Len() int
  Less(i, j int) bool
  Swap(i, j int)
}
```

### Decoupling

Separating code from from an implementation. This can be invaluable in unit
testing as it allows mocks to be utilized or using the concrete implementation
of the interface.

```go
type (
  customerStorer interface {
    Store(Customer) error
  }

  CustomerService struct {
    storer customerStorer
  }
)
```

### Restricting behavior

Behavior can be defined and restricted using an interface.

```go
type (
  config struct {

  }

  configGetter interfact {
    Get() int
  }
)

func (c *config) Get() int{}
func (c *config) Set(s int){}
```

## Pollution

Interfaces are meant to be discovered, not created. Overusing interfaces can
lead to unnecessary abstraction and unwanted performance overhead. When calling
a method through an interface, a lookup is required in a hash table to find the
concrete type the interface points to.

## Implementation

Interfaces should be implemented on the consumer side almost always. Due to
interfaces being implied, the producer does not need to define an interface.

## Returning interfaces

Returning an interface from a function or method is consider to be bad practice.
It can lead to cyclic dependency and can lead to packages being tightly coupled.
It is far better to:

- Return structs
- Accept interfaces

## References

- [100-go-mistakes-and-how-to-avoid-them](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
