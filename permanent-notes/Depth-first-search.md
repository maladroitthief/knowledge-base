---
tags:
  - idea
aliases:
---

# Depth-first-search

Depth first search is a graph traversal algorithm that travels as far as possible along edges before it backtracks. This is typically accomplished using a [Stack](Stack.md) to keep track of the nodes on the current path. This could be an implicit stack through using recursion or a literal stack data structure.

## Example

### go

```go
var (
	directions = [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
)

type graph struct {
	nodes [][]int
	rows  int
	cols  int
}

func NewGraph(x, y int) *graph {
	g := &graph{
		nodes: make([][]int, x),
		rows:  x,
		cols:  y,
	}
	for i := range g.nodes {
		g.nodes[i] = make([]int, y)
	}
	return g
}

func (g *graph) dfs(startX, startY int) {
	if len(g.nodes) <= 0 {
		return
	}
	visited := make([][]bool, g.rows)
	for i := range visited {
		visited[i] = make([]bool, g.cols)
	}
	g.dfsTraverse(startX, startY, visited)
}

func (g *graph) dfsTraverse(i, j int, visited [][]bool) {
	if visited[i][j] == true {
		return
	}
	visited[i][j] = true
	fmt.Printf("visited: %v, %v\n", i, j)
	for _, direction := range directions {
		nextI, nextJ := i+direction[0], j+direction[1]
		if nextI < 0 || nextI >= g.rows {
			continue
		}
		if nextJ < 0 || nextJ >= g.cols {
			continue
		}
		g.dfsTraverse(nextI, nextJ, visited)
	}
}
```

## References

- [Algorithms](Algorithms.md)
- [The-Algorithm-Design-Manual](The-Algorithm-Design-Manual.md)
- [Tech-Interview-Handbook](Tech-Interview-Handbook.md)
