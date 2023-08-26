type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Trapping-Rain-Water

Given `n` non-negative integers representing an elevation map where the width of each bar is `1`, compute how much water it can trap after raining.

## Method

Two points moving from out to middle. Move each pointer when it's max height is less than the other.

## Solution

### go

```go
func trap(height []int) int {
	result := 0
	l, r := 0, len(height)-1
	maxL, maxR := height[l], height[r]
	for l < r {
		if maxL < maxR {
			l++
			if maxL < height[l]{
				maxL = height[l]
			}
			result += maxL - height[l]
		} else {
			r--
			if maxR < height[r]{
				maxR = height[r]
			}
			result += maxR - height[r]
		}
	}
	return result
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/trapping-rain-water/)