type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Climbing-Stairs

You are climbing a staircase. It takes `n` steps to reach the top.

Each time you can either climb `1` or `2` steps. In how many distinct ways can you climb to the top?

## Method

Similar to Fibonacci. It's a lot leaner if handled iteratively.

## Solution

### go

```go
func climbStairs(n int) int {
	result := 0
	previous := 0
	prePrevious := 0
	for i := 1; i <= n; i++ {
		switch i {
			case 1:
				result = 1
			case 2:
				result = 2
			default:
				result = previous + prePrevious
		}
		prePrevious = previous
		previous = result
	}
	return result
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/climbing-stairs/)
