type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Maximum-Subarray

Given an integer array `nums`, find the subarray with the largest sum, and return _its sum_.

## Method

Replace nums[i] with nums[i-1]+nums[i] if it is greater. Replace the max with num[i] if it is greater

## Solution

### go

```go
func maxSubArray(nums []int) int {
	max := nums[0]
	for i := 1; i < len(nums); i++{
		if nums[i] < nums[i-1] + nums[i]{
			nums[i] = nums[i-1] + nums[i]
		}
		if max < nums[i]{
			max = nums[i]
		}
	}
	return max
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/maximum-subarray/)