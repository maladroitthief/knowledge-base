type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Longest-Substring-Without-Repeating-Characters

Given a string `s`, find the length of the **longest** **substring** without repeating characters.

## Method

Keep two pointers

## Solution

### go

```go
func lengthOfLongestSubstring(s string) int {
	dict := map[byte]bool{}
	length, max := 0,0
	j := 0
	for i := range s {
		for dict[s[i]] {
			dict[s[j]] = false
			length--
			j++
		}
		dict[s[i]] = true
		length++
		if max < length {
			max = length
		}
	}
	return max 
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/longest-substring-without-repeating-characters/)