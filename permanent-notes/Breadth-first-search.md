---
tags:
 - idea
aliases:
---

# Breadth first search

Breadth-first search is a graph traversal algorithm that starts at a node and travels to all other nodes at the current depth before moving further into the graph. [Queues](Queue.md) are a good data structure for tracking of the nodes that have been encountered, but not traversed.

It is important to use a double-ended queue and not an array due to the time complexity of dequeuing.

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

func (g *graph) bfs(startX, startY int) {
	if len(g.nodes) <= 0 {
		return
	}
	visited := make([][]bool, g.rows)
	for i := range visited {
		visited[i] = make([]bool, g.cols)
	}

	queue := [][2]int{}
	g.bfsTraverse(startX, startY, visited, queue)
}

func (g *graph) bfsTraverse(
	x, y int,
	visited [][]bool,
	queue [][2]int,
) {
	queue = append(queue, [2]int{x, y})
	for len(queue) > 0 {
		i, j := queue[0][0], queue[0][1]
		queue = queue[1:]
		if visited[i][j] == true {
			continue
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
			queue = append(queue, [2]int{nextI, nextJ})
		}
	}
}
```

## References

- [Algorithms](Algorithms.md)
- [Tech-Interview-Handbook](Tech-Interview-Handbook.md)
- [The-Algorithm-Design-Manual](The-Algorithm-Design-Manual.md)
