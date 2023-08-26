type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Combination-Sum

Given an array of **distinct** integers `candidates` and a target integer `target`, return _a list of all **unique combinations** of_ `candidates` _where the chosen numbers sum to_ `target`_._ You may return the combinations in **any order**.

The **same** number may be chosen from `candidates` an **unlimited number of times**. Two combinations are unique if the

frequency

of at least one of the chosen numbers is different.

The test cases are generated such that the number of unique combinations that sum up to `target` is less than `150` combinations for the given input.

## Method

DFS to back track by passing the index

## Solution

### go

```go
func combinationSum(candidates []int, target int) [][]int {
	var dfs func(int, int, []int, [][]int) [][]int
	dfs = func(i, sum int, combo []int, result [][]int) [][]int {
		if sum == target {
			result = append(result, append([]int(nil), combo...))
			return result
		}
		if sum > target {
			return result
		}
		for j := i; j < len(candidates); j++ {
			result = dfs(
				j,
				sum+candidates[j],
				append(combo, candidates[j]),
				result,
			)
		}
		return result
	}
	
	return dfs(0, 0, nil, nil)
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/combination-sum/)
