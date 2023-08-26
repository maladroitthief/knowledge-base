type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Best Time to Buy and Sell Stock

You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.

You want to maximize your profit by choosing a **single day** to buy one stock and choosing a **different day in the future** to sell that stock.

Return _the maximum profit you can achieve from this transaction_. If you cannot achieve any profit, return `0`.

## Method

Iterate over array once

## Solution

### go

```go
func maxProfit(prices []int) int {
	if len(prices) <= 0 {
		return 0
	}
	profit := 0
	buyPrice := prices[0]
	for i := 1; i < len(prices); i++{
		if prices[i] <= buyPrice {
			buyPrice = prices[i]
		} else if prices[i] - buyPrice > profit{
			profit = prices[i] - buyPrice
		}
	}
	return profit
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/)