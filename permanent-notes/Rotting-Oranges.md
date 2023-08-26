type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Rotting-Oranges

You are given an `m x n` `grid` where each cell can have one of three values:

- `0` representing an empty cell,
- `1` representing a fresh orange, or
- `2` representing a rotten orange.

Every minute, any fresh orange that is **4-directionally adjacent** to a rotten orange becomes rotten.

Return _the minimum number of minutes that must elapse until no cell has a fresh orange_. If _this is impossible, return_ `-1`.

## Method

BFS

## Solution

### go

```go
var directions = [][2]int{
	{1,0},
	{-1,0},
	{0,1},
	{0,-1},
}

func orangesRotting(grid [][]int) int {
	result := 0
	freshOranges := 0
	queue := [][2]int{}
	for x := range grid{
		for y := range grid[x] {
			switch grid[x][y] {
				case 1:
					freshOranges++
				case 2:
					queue = append(queue, [2]int{x, y})
			}
		}
	}
	if freshOranges == 0 {
		return 0
	}
	for len(queue) > 0 {
		curr := queue
		queue = [][2]int{}
		for len(curr) > 0 {
			coord := curr[0]
			curr = curr[1:]
			x, y := coord[0], coord[1]
			for _, d := range directions{
				dx, dy := x+d[0], y+d[1]
				if dx < 0 || dx >= len(grid) {
					continue
				}
				if dy < 0 || dy >= len(grid[dx]) {
					continue
				}
				if grid[dx][dy] == 1 {
					grid[dx][dy] = 2
					freshOranges--
					queue = append(queue, [2]int{dx, dy})
				}
			}
		}
		result++
		if freshOranges <= 0{
			return result
		}
	}
	return -1
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/rotting-oranges/)