type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Valid-Palindrome

A phrase is a **palindrome** if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string `s`, return `true` _if it is a **palindrome**, or_ `false` _otherwise_.

## Method

Two indices

## Solution

### go

```go
func isPalindrome(s string) bool {
	candidate := strings.ToLower(s)
	candidate = clean([]byte(candidate))
	i := 0
	j := len(candidate)-1
	for i < j {
		if candidate[i] != candidate[j] {
			return false
		}
		i++
		j--
	}
	return true
}

func clean(s []byte) string{
	j := 0
	for _, b := range s {
		if ('a' <= b && b <= 'z') || ('0' <= b && b <= '9'){
			s[j] = b
			j++
		}
	}
	return string(s[:j])
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/valid-palindrome/)