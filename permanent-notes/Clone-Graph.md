type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Clone-Graph

Given a reference of a node in a **[connected](https://en.wikipedia.org/wiki/Connectivity_(graph_theory)#Connected_graph)** undirected graph.

Return a [**deep copy**](https://en.wikipedia.org/wiki/Object_copying#Deep_copy) (clone) of the graph.

Each node in the graph contains a value (`int`) and a list (`List[Node]`) of its neighbors.

```
class Node {
	public int val;
	public List<Node> neighbors;
}
```

**Test case format:**

For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with `val == 1`, the second node with `val == 2`, and so on. The graph is represented in the test case using an adjacency list.

**An adjacency list** is a collection of unordered **lists** used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with `val = 1`. You must return the **copy of the given node** as a reference to the cloned graph.

## Method

DFS

## Solution

### go

```go
func cloneGraph(node *Node) *Node {
	visited := map[*Node]*Node{}
	dfs(node, visited)
	return visited[node]
}

func dfs(node *Node, visited map[*Node]*Node) {
	if node == nil {
		return
	}
	_, ok := visited[node]
	if ok {
		return
	}
	newNode := &Node{
		Val: node.Val,
	}
	visited[node] = newNode
	for _, neighbor := range node.Neighbors {
		_, ok := visited[neighbor]
		if !ok{
			dfs(neighbor, visited)
		}
		newNode.Neighbors = append(
			newNode.Neighbors,
			visited[neighbor],
		)
	}
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/clone-graph/)

