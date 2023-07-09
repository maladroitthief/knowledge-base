type: #idea
subject: [Computational-technique](Computational-technique.md)
<!-- Subject should be a hub note -->
# Recursion

Recursion is a problem solving strategy that involves breaking a problem down into smaller and smaller pieces and using those solutions collectively to find the original solution. All recursive functions have at least these two parts:

1. A base case where the recursion stops
2. Breaking the problem down and calling the function recursively

## Techniques

### Memoization

Some recursive functions may end up calling the same function multiple times. When possible, store the results of previously calculated functions and re-use the to improve efficiency.

## Examples

### go

```go
func fibonacci(n int) int {
	// base case
	if n <= 1 {
		return n
	}
	// recursive case
	return fibonacci(n - 1) + fibonacci(n - 2)
}
```

---
# References
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
