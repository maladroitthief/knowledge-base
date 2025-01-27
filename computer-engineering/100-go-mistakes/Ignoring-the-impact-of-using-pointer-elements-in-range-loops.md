---
title: Ignoring the impact of using pointer elements in range loops
layout: idea
tags:
  - 100-go-mistakes
---

# Ignoring the impact of using pointer elements in range loops

When not being careful, it's possible to reference the wrong elements with range
loops.

## Mistake

Here we are referencing the range variable, customer, which will result in all
elements of the customers slice being the same value.

```go
func (s *Store) storeCustomers(customers []Customer) {
	for _, customer := range customers {
    // This pointer is to the range variable customer, not the customers slice
		s.m[customer.ID] = &customer
	}
}
```

## Fix

```go
func (s *Store) storeCustomers(customers []Customer) {
	for _, customer := range customers {
    // create a local variable first
    current := customer
		s.m[customer.ID] = &current
	}
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
