type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Validate-Binary-Search-Tree

Given the `root` of a binary tree, _determine if it is a valid binary search tree (BST)_.

A **valid BST** is defined as follows:

- The left subtree of a node contains only nodes with keys **less than** the node's key.
- The right subtree of a node contains only nodes with keys **greater than** the node's key.
- Both the left and right subtrees must also be binary search trees.

## Method

Use DFS

## Solution

### go

```go
func isValidBST(root *TreeNode) bool {
	var dfs func(*TreeNode, int, int) bool
	dfs = func(node *TreeNode, low, high int) bool {
		if node == nil {
			return true
		}
		if low >= node.Val || high <= node.Val {
			return false
		}
		if !dfs(node.Left, low, node.Val){
			return false
		}
		if !dfs(node.Right, node.Val, high){
			return false
		}
		return true
	}
	return dfs(root, math.MinInt64, math.MaxInt64)
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/validate-binary-search-tree/)