type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Coin-Change

You are given an integer array `coins` representing coins of different denominations and an integer `amount` representing a total amount of money.

Return _the fewest number of coins that you need to make up that amount_. If that amount of money cannot be made up by any combination of the coins, return `-1`.

You may assume that you have an infinite number of each kind of coin.

## Method

Dynamic programming. Keep array of coin counts for each sub-amount

## Solution

### go

```go
func coinChange(coins []int, amount int) int {
	dp := make([]int, amount+1)
	for i := range dp {
		dp[i] = amount+1
	}
	dp[0] = 0
	for a := 1; a <= amount; a++{
		for _, c := range coins {
			if a - c < 0 {
				continue
			}
			dp[a] = min(dp[a], dp[a - c]+ 1)
		}
	}
	if dp[amount] == amount+1{
		return -1
	}
	return dp[amount]
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/coin-change/)
