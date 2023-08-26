type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Random-Note

Given two strings `ransomNote` and `magazine`, return `true` _if_ `ransomNote` _can be constructed by using the letters from_ `magazine` _and_ `false` _otherwise_.

Each letter in `magazine` can only be used once in `ransomNote`.

## Method

Keep a dictionary of the magazine. Check in the ransomNote loop if we are over spent

## Solution

### go

```go
func canConstruct(ransomNote string, magazine string) bool {
	if len(ransomNote) > len(magazine) {
		return false
	}
	letters := map[rune]int{}
	for _, char := range magazine{
		letters[char]++
	}
	for _, char := range ransomNote {
		letters[char]--
		if letters[char] < 0 {
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
[LeetCode](https://leetcode.com/problems/ransom-note/)
