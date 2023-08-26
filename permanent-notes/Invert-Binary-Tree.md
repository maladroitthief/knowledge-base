type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Invert-Binary-Tree

Given the `root` of a binary tree, invert the tree, and return _its root_.

## Method

Travel through recursion. Create a traverse function

## Solution

### go

```go
func invertTree(root *TreeNode) *TreeNode {
	traverse(root)
	return root
}

func traverse(root *TreeNode) {
	if root == nil {
		return
	}
	root.Left, root.Right = root.Right, root.Left
	traverse(root.Left)
	traverse(root.Right)
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/invert-binary-tree/)
