type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Insert-Interval

You are given an array of non-overlapping intervals `intervals` where `intervals[i] = [starti, endi]` represent the start and the end of the `ith` interval and `intervals` is sorted in ascending order by `starti`. You are also given an interval `newInterval = [start, end]` that represents the start and end of another interval.

Insert `newInterval` into `intervals` such that `intervals` is still sorted in ascending order by `starti` and `intervals` still does not have any overlapping intervals (merge overlapping intervals if necessary).

Return `intervals` _after the insertion_.

## Method

Iterate until reaching the new interval, grow new interval until it no longer overlaps, iterate over the remaining array.

## Solution

### go

```go
func insert(intervals [][]int, newInterval []int) [][]int {
	result := make([][]int, 0)
	i := 0
	for i < len(intervals) && intervals[i][1] < newInterval[0]{
		result = append(result, intervals[i])
		i++
	}
	for i < len(intervals) && intervals[i][0] <= newInterval[1]{ 
		newInterval[0] = min(intervals[i][0], newInterval[0])
		newInterval[1] = max(intervals[i][1], newInterval[1])
		i++
	}
	result = append(result, newInterval)
	for i < len(intervals) {
		result = append(result, intervals[i])
		i++
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
[LeetCode](https://leetcode.com/problems/insert-interval/)

