type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Permutations

Given an array `nums` of distinct integers, return _all the possible permutations_. You can return the answer in **any order**.

## Method

Recursively build up an array. Keep a separate pool array with all numbers but the current iteration.

## Solution

### go

```go
func permute(nums []int) [][]int {
	result := [][]int{}
	
	var perm func(curr, pool []int)
	perm = func(curr, pool []int) {
		if len(pool) == 0 {
			result = append(result, curr)
			return
		}
		for i, p := range pool {
			perm(
				append(curr, p),
				append(
					append([]int{}, pool[:i]...),
					pool[i+1:]...,
				),
			)
		}
	}
	perm([]int{}, nums)
	
	return result    
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/permutations/)

