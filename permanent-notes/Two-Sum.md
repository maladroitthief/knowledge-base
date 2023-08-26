type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Two Sum

Given an array of integers `nums` and an integer `target`, return _indices of the two numbers such that they add up to `target`_.
You may assume that each input would have **_exactly_ one solution**, and you may not use the _same_ element twice.
You can return the answer in any order.

## Method

Use a hash map to keep track of numbers we have seen before.

## Solution

### go

```go
func twoSum(nums []int, target int) []int {
	seenNums := map[int]int{}
	for i, num := range nums {
		indexPair, ok := seenNums[target - num]	
		if ok {
			return []int{indexPair, i}	
		}
		seenNums[num] = i
	}
	return []int{}
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/two-sum/)
