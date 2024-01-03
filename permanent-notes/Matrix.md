---
tags:
 - idea
aliases:
---

# Matrix

A matrix is a 2-d array data structure that could be considered a type of [graph](Graph.md).

## Edge cases

- Empty matrices
- 1 x 1 matrix
- Matrix with only 1 row or column

## Techniques

### Creating an empty N x M matrix

For graph traversal it can be incredibly helpful to start with an empty matrix.

```go
n := 9
m := 9
emptyMatrix := make([][]int, n)
for i := range emptyMatrix {
	emptyMatrix[i] = make([]int, m)
}
```

### Copy a matrix

```go
duplicate := make([][]int, len(matrix))
for i := range duplicate {
	duplicate[i] = make([]int, len(matrix[i]))
	copy(duplicate[i], matrix[i])
}
```

### Transposing a matrix

Transposing a matrix is change the columns into rows and the rows into columns.

```go
transpose := make([][]int, len(matrix[0]))
for i := range transpose {
	transpose[i] = make([]int, len(matrix))
}
for i := range transpose {
	for j := range transpose[i] {
		transpose[i][j] = matrix[j][i]
	}
}
```

## References

- [Data-Structures](Data-Structures.md)
- [Tech-Interview-Handbook](Tech-Interview-Handbook.md)
