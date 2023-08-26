type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# First-Bad-Version

You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

Suppose you have `n` versions `[1, 2, ..., n]` and you want to find out the first bad one, which causes all the following ones to be bad.

You are given an API `bool isBadVersion(version)` which returns whether `version` is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

## Method

Iterative binary search

## Solution

### go

```go
func firstBadVersion(n int) int {
	start := 0
	end := n
	mid := start+(end-start)/2
	for start < end {
		if isBadVersion(mid) {
			end = mid
		} else {
			start = mid + 1
		}
		mid = start+(end-start)/2
	}
	return start
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/first-bad-version/)
