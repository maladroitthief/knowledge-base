type: #idea
subject: [Algorithms](Algorithms.md)
<!-- Subject should be a hub note -->
# Topological sorting

A topological sort is a linear ordering of a directed graph. The ordering works similarly to [Depth-first-search](Depth-first-search.md), but the nodes are considered "visited" when all of it's dependencies are visited. This is an algorithm that is commonly used for discovering dependencies or prerequisites between nodes.

## Examples

### go

```go
type graph struct {
	nodes []*node
}

type node struct {
	name  string
	edges []*node
}

func NewGraph() *graph {
	return &graph{nodes: []*node{}}
}

func NewNode(name string) *node {
	return &node{name: name, edges: []*node{}}
}

func (g *graph) AddNode(n *node) {
	g.nodes = append(g.nodes, n)
}

func (n *node) AddEdge(e *node) {
	n.edges = append(n.edges, e)
}

func (g *graph) TopologicalSort() {
	if len(g.nodes) <= 0 {
		return
	}
	visited := map[*node]bool{}
	stack := []*node{}
	for _, node := range g.nodes {
		if visited[node] == false {
			stack = g.tsTraverse(node, visited, stack)
		}
	}
	for _, n := range stack {
		fmt.Println(n.name)
	}
}

func (g *graph) tsTraverse(
	node *node,
	visited map[*node]bool,
	stack []*node,
) []*node {
	visited[node] = true
	for _, edge := range node.edges {
		if visited[edge] == false {
			stack = g.tsTraverse(edge, visited, stack)
		}
	}
	return append(stack, node)
}
```



---
# References
<!-- What references back up this idea -->
[The-Algorithm-Design-Manual](The-Algorithm-Design-Manual.md)
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)