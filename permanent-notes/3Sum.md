type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# 3Sum

Given an integer array nums, return all the triplets `[nums[i], nums[j], nums[k]]` such that `i != j`, `i != k`, and `j != k`, and `nums[i] + nums[j] + nums[k] == 0`.

Notice that the solution set must not contain duplicate triplets.

## Method

Sliding window technique on a sorted array.

## Solution

### go

```go
func threeSum(nums []int) [][]int {
	sort.Ints(nums)
	result := [][]int{}
	for i, a := range nums {
		if i > 0 && a == nums[i-1] {
			continue
		}
		left, right := i+1, len(nums)-1
		for left < right {
			threeSum := a + nums[left] + nums[right]
			if threeSum < 0 {
				left++
			} else if threeSum > 0 {
				right--
			} else {
				result = append(
					result,
					[]int{a, nums[left], nums[right]},
				)
				left++
				for left < right && nums[left] == nums[left-1]{
					left++
				}
			}
		}
	}
	return result
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/3sum/)
