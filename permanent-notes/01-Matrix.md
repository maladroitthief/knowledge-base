type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# 01-Matrix

Given an `m x n` binary matrix `mat`, return _the distance of the nearest_ `0` _for each cell_.

The distance between two adjacent cells is `1`.

## Method

Use BFS. Add indices to the queue starting with 0.

## Solution

### go

```go
var directions = [4][2]int{
	{0, 1},
	{0, -1},
	{1, 0},
	{-1, 0},
}

func updateMatrix(mat [][]int) [][]int {
	queue := [][2]int{}
	for i := range mat{
		for j := range mat[i]{
			if mat[i][j] == 0 {
				queue = append(queue, [2]int{i, j})
			} else {
				mat[i][j] = math.MaxInt64
			}
		}
	}
	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]
		for _, direction := range directions {
			x := current[0] + direction[0]
			y := current[1] + direction[1]
			if x < 0 || x >= len(mat) || y < 0 || y >= len(mat[x]) {
				continue
			}
			if mat[x][y] <= mat[current[0]][current[1]] {
				continue
			}
			queue = append(queue, [2]int{x, y})
			mat[x][y] = mat[current[0]][current[1]]+1
		}
	}
	return mat
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/01-matrix/)