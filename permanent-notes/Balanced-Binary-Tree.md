type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Balanced-Binary-Tree

Given a binary tree, determine if it is **height-balanced**

## Method

Use DFS to return the height at each node

## Solution

### go

```go
func isBalanced(root *TreeNode) bool {
	_, ok := dfs(root)
	return ok
}

func dfs(root *TreeNode) (int, bool){
	if root == nil {
		return 0, true
	}
	left, ok := dfs(root.Left)
	if !ok {
    return 0, false
	}
	right, ok := dfs(root.Right)
	if !ok {
    return 0, false
	}
	if math.Abs(float64(left) - float64(right)) > 1 {
    return 0, false
	}
	if left > right {
    return left+1, true
	}
	return right+1, true
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/balanced-binary-tree/)