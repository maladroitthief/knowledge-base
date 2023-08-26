type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Product-of-Array-Except-Self

Given an integer array `nums`, return _an array_ `answer` _such that_ `answer[i]` _is equal to the product of all the elements of_ `nums` _except_ `nums[i]`.

The product of any prefix or suffix of `nums` is **guaranteed** to fit in a **32-bit** integer.

You must write an algorithm that runs in `O(n)` time and without using the division operation.

## Method

Approach from left and right

## Solution

### go

```go
func productExceptSelf(nums []int) []int {
	result := make([]int, len(nums))
	prefix := 1
	for i := 0; i < len(nums); i++ {
		result[i] = prefix
		prefix = prefix * nums[i]
	}
	suffix := 1
	for i := len(nums)-1; i >= 0; i-- {
		result[i] = suffix * result[i]
		suffix = suffix * nums[i]
	}
	return result
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/product-of-array-except-self/)
