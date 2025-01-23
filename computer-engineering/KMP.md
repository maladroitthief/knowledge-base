---
title: KMP
layout: idea
tags:
  - algorithms
---

# KMP Algorithm

Knuth-Morris-Pratt (KMP) is an algorithm for pattern matching in a string
similar to the [Sliding-window](/computer-engineering/Sliding-window) technique.
The primary difference in KMP is that the algorithm does not backtrack on the
text string and instead creates a lookup up index in the pattern string.

To accomplish this, a prefix look up table is generated where all the
sub-strings in the pattern string that match the largest repeating prefix are
given index values. This index value is used as a point of reference for where
to backtrack in the pattern string when a match is not found. This allows
pattern matching without the need to back track in the text string.

## Complexity

KMP has a time complexity of `O(n + m)` where `n` is the text length and `m` is
the pattern length. It has an auxiliary space of `O(m)`.

## Examples

### python

```python
def search(pattern, text):
    results = []
    lps = setup_lps(pattern)
    j = 0
    for i, ch in enumerate(text):
        # if miss, rewind using the index found in the LPS
        while j and pattern[j] != ch:
            j = lps[j - 1]
        # match
        if pattern[j] == ch:
            # iterate until the match is confirmed
            if j == len(pattern) - 1:
                results.append(i - j)
                j = lps[j]
            else:
                j += 1
    return results

def setup_lps(pattern) -> List[int]:
    lps = [0] * len(pattern)
    prefixPointer = 0
    for i in range(1, len(pattern)):
        # rewind until match or back to the beginning
        while prefixPointer and pattern[i] != pattern[prefixPointer]:
            prefixPointer = lps[prefixPointer - 1]
        # increment the pointer and record the index
        if pattern[prefixPointer] == pattern[i]:
            prefixPointer += 1
            lps[i] = prefixPointer
    return lps
```

### go

```go
func search(pattern, text string) []int {
	results := []int{}
	textLength := len(text)
	patternLength := len(pattern)
	i := 0
	j := 0
	// pre-process the pattern
	lps := setupLPS(pattern)
	for (textLength - i) >= (patternLength - j) {
		if pattern[j] == text[i] {
			i++
			j++
		}
		if j == patternLength {
			results = append(results, i-j)
			j = lps[j-1]
			continue
		}
		if i < textLength && pattern[j] != text[i] {
			if j != 0 {
				j = lps[j-1]
			} else {
				i++
			}
		}
	}
	return results
}

func setupLPS(pattern string) []int {
	lps := make([]int, len(pattern))
	prefixPointer := 0
	i := 1
	for i < len(pattern) {
		// increment the pointer and record the index
		if pattern[i] == pattern[prefixPointer] {
			prefixPointer += 1
			lps[i] = prefixPointer
			i++
		} else {
			if prefixPointer != 0 {
				prefixPointer = lps[prefixPointer-1]
			} else {
				lps[i] = 0
				i++
			}
		}
	}
	return lps
}
```
