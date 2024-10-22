---
title: Graph
layout: idea
tags:
  - data-structures
---

# Graph

A graph is a collection of nodes that are connected to each other by edges.
Edges can be either directed (one-way) or undirected and they can also have
weights (values). A tree can be considered an undirected graph with no cycles.

| Operation            | Big-O    |
| -------------------- | -------- |
| Depth-first search   | O(N + E) |
| Breadth-first search | O(N + E) |
| Topological sort     | O(N + E) |

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

- [Depth-first-search](/computer-engineering/Depth-first-search)
- [Breadth-first-search](/computer-engineering/Breadth-first-search)
- [Topological-sorting](/computer-engineering/Topological-sorting)

## References

- [Tech-Interview-Handbook](/reference/Tech-Interview-Handbook)
