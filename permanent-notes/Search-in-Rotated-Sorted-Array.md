type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Search-in-Rotated-Sorted-Array

There is an integer array `nums` sorted in ascending order (with **distinct** values).

Prior to being passed to your function, `nums` is **possibly rotated** at an unknown pivot index `k` (`1 <= k < nums.length`) such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (**0-indexed**). For example, `[0,1,2,4,5,6,7]` might be rotated at pivot index `3` and become `[4,5,6,7,0,1,2]`.

Given the array `nums` **after** the possible rotation and an integer `target`, return _the index of_ `target` _if it is in_ `nums`_, or_ `-1` _if it is not in_ `nums`.

You must write an algorithm with `O(log n)` runtime complexity.

## Method

Binary search both sides of mid

## Solution

### go

```go
func search(nums []int, target int) int {
	l, r := 0, len(nums) - 1
	for l <= r {
		mid := (r+l)/2
		if nums[mid] == target {
			return mid
		}
		if nums[l] <= nums[mid]{
			if target > nums[mid] || target < nums[l] {
				l = mid+1
			} else {
				r = mid-1
			}
		} else {
			if target < nums[mid] || target > nums[r] {
				r = mid-1
			} else {
				l = mid+1
			}
		}
	}
	return -1
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/search-in-rotated-sorted-array/)
