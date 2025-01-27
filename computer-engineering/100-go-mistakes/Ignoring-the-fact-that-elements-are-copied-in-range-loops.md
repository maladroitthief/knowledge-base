---
title: Ignoring the fact that elements are copied in range loops
layout: idea
tags:
  - 100-go-mistakes
---

# Ignoring the fact that elements are copied in range loops

The `range` keyword is a convenient way to iterate over data structures.

## Mistake

`range` performs a copy on all the elements of the data structure.

```go
accounts := []account{
	{balance: 100.},
	{balance: 200.},
	{balance: 300.},
}

for _, a := range accounts {
	a.balance += 1000 // This will not modify the original slice
}
```

## Fix

```go
accounts := []account{
	{balance: 100.},
	{balance: 200.},
	{balance: 300.},
}

// using the index for the slice
for i := range accounts {
	accounts[i].balance += 1000 // This modifies the accounts object
}

// classic for loop
for i := 0; i < len(accounts); i++ {
	accounts[i].balance += 1000 // This modifies the accounts object
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
