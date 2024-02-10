---
tags:
  - idea
aliases:
---

# Tree

Trees are hierarchical data structures that are made up of a series of nodes. Each node can have many children but needs to have one parent. If a node does not have a parent, it is considered to be a root node.

Trees can also be considered as a undirected, connect, acyclic [Graph](Graph.md).

## Common terms

- **Neighbor**: The parent or child nodes of the current node
- **Ancestor**: Any node from the current node to the root node
- **Descendant**: Any node in the current node's subtree
- **Degree**: Number of children at current node
- **Degree of a tree**: Max degree of nodes in the tree
- **Distance**: Number of edges between two nodes
- **Level/Depth**: Number of edges between root and node
- **Width**: Number of nodes in a level
- **Skewed**: Nodes have very few children, like a linked list

## Types of trees

- [Trie](Trie.md)
- [Binary-tree](Binary-tree.md)
- [Binary-search-tree](Binary-search-tree.md)

## Common routines

- Insert
- Delete
- Count number of nodes
- Search
- Height

## References

- [Data-Structures](Data-Structures.md)
- [Tech-Interview-Handbook](Tech-Interview-Handbook.md)
