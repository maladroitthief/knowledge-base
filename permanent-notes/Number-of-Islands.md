type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Number-of-Islands

Given an `m x n` 2D binary grid `grid` which represents a map of `'1'`s (land) and `'0'`s (water), return _the number of islands_.

An **island** is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

## Method

DFS with visited list

## Solution

### go

```go
var directions = [][2]int{
	{0, 1},
	{0, -1},
	{1, 0},
	{-1, 0},
}

func numIslands(grid [][]byte) int {
	visited := map[[2]int]bool{}
	result := 0
	var dfs func(x, y int)
	
	dfs = func(x, y int){
		if grid[x][y] == '0' {
			return
		}
		if visited[[2]int{x, y}]{
			return
		}
		visited[[2]int{x, y}] = true
		for _, d := range directions{
			nextX, nextY := x+d[0], y+d[1]
			if nextX < 0 || nextX >= len(grid){
				continue
			}
			if nextY < 0 || nextY >= len(grid[nextX]) {
				continue
			}
			dfs(nextX, nextY)
		}
	}
	
	for x := range grid{
		for y := range grid[x]{
			if !visited[[2]int{x, y}] && grid[x][y] == '1'{
				result++
				dfs(x, y)
			}
		}
	}
	
	return result
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/number-of-islands/)
