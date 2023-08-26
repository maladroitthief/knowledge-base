type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Valid Anagram

Given two strings `s` and `t`, return `true` _if_ `t` _is an anagram of_ `s`_, and_ `false` _otherwise_.

An **Anagram** is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

## Method

Count the frequency using a map or array

## Solution

### go

```go
func isAnagram(s string, t string) bool {
	if len(s) != len(t){
		return false
	}
	letters := map[byte]int{}
	for i := range s {
		letters[s[i]]++
		letters[t[i]]--
	}
	for i := range letters{
		if letters[i] != 0 {
			return false
		}
	}
	return true
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/valid-anagram/)