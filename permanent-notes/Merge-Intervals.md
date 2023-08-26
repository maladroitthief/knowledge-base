type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Merge-Intervals

Given an array of `intervals` where `intervals[i] = [starti, endi]`, merge all overlapping intervals, and return _an array of the non-overlapping intervals that cover all the intervals in the input_.

## Method

Use two pointers, sort the slice before starting

## Solution

### go

```go
func merge(intervals [][]int) [][]int {
	result := [][]int{}
	
	sort.Slice(
		intervals,
		func(x, y int) bool {
			return intervals[x][0] < intervals[y][0]
		},
	)
	
	i, j := 0, 1
	for i < len(intervals) {
		current := intervals[i]
		for j < len(intervals) && intervals[i][1] >= intervals[j][0]{
			current[0] = min(intervals[i][0], intervals[j][0])
			current[1] = max(intervals[i][1], intervals[j][1])
			j++
		}
	
		result = append(result, current)
		i = j
		j = i + 1
	}
	
	return result
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/merge-intervals/)

