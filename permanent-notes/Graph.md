type: #idea
subject: [Data-Structures](Data-Structures.md)
<!-- Subject should be a hub note -->
# Graph

A graph is a collection of nodes that are connected to each other by edges. Edges can be either directed (one-way) or undirected and they can also have weights (values). A tree can be considered an undirected graph with no cycles.

| Operation | Big-O |
|-----------|-------|
| Depth-first search | O(N + E) |
| Breadth-first search | O(N + E) |
| Topological sort | O(N + E) |

> N being number of nodes and E being number of edges

## Graph representation

- Adjacency matrix
- Adjacency list
- Hash table of hash tables

## Corner cases

- Empty graph
- Graph with 1/2 nodes
- Disconnected graphs
- Graph with cycles, keep track of visited nodes

## Graph traversal and sorting

- [Depth-first-search](Depth-first-search.md)
- [Breadth-first-search](Breadth-first-search.md)
- [Topological-sorting](Topological-sorting.md)

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)