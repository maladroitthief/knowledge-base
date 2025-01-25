---
title: Interface pollution
layout: idea
tags:
  - 100-go-mistakes
---

# Interface pollution

Interfaces are one of the most valuable tools for structuring Go code and as a
result they are often abused creating unnecessary abstractions and difficult to
follow code.

## Mistake

Creating interfaces and abstractions early. We should not be creating an
interface before their is code to implement it. Abstractions should be
discovered, not created.

## Fix

Interfaces can be appropriate for the following categories:

### Common behavior

Consider the `sort` interface

```go
type Interface interface {
	Len() int
	Less(i, j int) bool
	Swap(i, j int)
}
```

### Decoupling

Coupled

```go
type CustomerService struct {
	store mysql.Store
}

func (cs CustomerService) CreateNewCustomer(id string) error {
	customer := Customer{id: id}
	return cs.store.StoreCustomer(customer)
}
```

Decoupled

```go
type customerStorer interface {
	StoreCustomer(Customer) error
}

type CustomerService struct {
	storer customerStorer
}

func (cs CustomerService) CreateNewCustomer(id string) error {
	customer := Customer{id: id}
	return cs.storer.StoreCustomer(customer)
}
```

### Restricting Behavior

Concrete implementation

```go
type IntConfig struct {
	// ...
}

func (c *IntConfig) Get() int {
	// Retrieve configuration
}

func (c *IntConfig) Set(value int) {
	// Update configuration
}
```

Restricted implementation

```go
type intConfigGetter interface {
	Get() int
}

type Foo struct {
	threshold intConfigGetter
}

func NewFoo(threshold intConfigGetter) Foo {
	return Foo{threshold: threshold}
}

func (f Foo) Bar() {
	threshold := f.threshold.Get()
	// ...
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
