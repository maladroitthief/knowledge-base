type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Longest-Palindrome

Given a string `s` which consists of lowercase or uppercase letters, return _the length of the **longest palindrome**_ that can be built with those letters.

Letters are **case sensitive**, for example, `"Aa"` is not considered a palindrome here.

## Method

Keep track of frequency. Pad 1 if the lengths don't align to account for odd lengths.

## Solution

### go

```go
func longestPalindrome(s string) int {
	seen := make([]bool, 58)
	length := 0
	for _, char := range s {
		index := int(char-'A')
		if seen[index] {
			seen[index] = false
			length += 2
		} else {
			seen[index] = true
		}
	}
	if len(s) > length {
		length++
	}
	return length
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/longest-palindrome/)
