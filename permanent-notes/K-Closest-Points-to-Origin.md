type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# K-Closest-Points-to-Origin

Given an array of `points` where `points[i] = [xi, yi]` represents a point on the **X-Y** plane and an integer `k`, return the `k` closest points to the origin `(0, 0)`.

The distance between two points on the **X-Y** plane is the Euclidean distance (i.e., `√(x1 - x2)2 + (y1 - y2)2`).

You may return the answer in **any order**. The answer is **guaranteed** to be **unique** (except for the order that it is in).

## Method

Either use a heap or sort the array by distance

## Solution

### go

```go
func kClosest(points [][]int, k int) [][]int {
	sort.Slice(
		points,
		func(i, j int) bool {
			// return distance(points[i][0], points[i][1]) < distance(points[j][0], points[j][1])
			return points[i][0] * points[i][0] + points[i][1] * points[i][1] <
			points[j][0] * points[j][0] + points[j][1] * points[j][1]
		},
	)
	return points[:k]
}

func distance(x, y int) float64 {
	return math.Sqrt(
	  math.Pow(0 - float64(x), 2) + math.Pow(0 - float64(y), 2),
	)
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/k-closest-points-to-origin/)
