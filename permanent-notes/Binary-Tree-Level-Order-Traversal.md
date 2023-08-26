type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Binary-Tree-Level-Order-Traversal

Given the `root` of a binary tree, return _the level order traversal of its nodes' values_. (i.e., from left to right, level by level).

## Method

Use BFS and a queue

## Solution

### go

```go
type Node struct {
	root *TreeNode
	height int
}

func levelOrder(root *TreeNode) [][]int {
	result := [][]int{}
	queue := []Node{Node{root: root, height: 0}}
	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]
		if current.root == nil {
			continue
		}
		queue = append(
			queue,
			Node {
				root: current.root.Left,
				height: current.height+1,
			},
		)
		queue = append(
			queue,
			Node {
				root: current.root.Right,
				height: current.height+1,
			},
		)
		if current.height >= len(result) {
			result = append(result, []int{})
		}
		result[current.height] = append(
			result[current.height],
			current.root.Val,
		)
	}
	return result
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/binary-tree-level-order-traversal/)
