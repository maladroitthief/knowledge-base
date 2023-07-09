type: #idea
subject: [Algorithms](Algorithms.md)
<!-- Subject should be a hub note -->
# Rabin-Karp Algorithm

The Rabin-Karp algorithm is a method of finding all occurrences of a sub-string in a given string. The naive approach to this solution would be to use the [Sliding-window](Sliding-window.md) technique. Rabin-Karp has a similar approach, but instead of comparing the window to the sub-string, it instead compares hash values using a [rolling hash function](Rolling-Hash-Function).

## Complexity

It has an average/best case time complexity of $O(n+m)$ and a worse case time complexity of $O(n * m)$. The worst case would occur if all the calculated hash values of the text were the same as the calculated hash of the pattern. It has auxiliary complexity of $O(1)$.

## Hashing function

It is commonly recommended that the hashing value should be an integer. If a weak hashing function is used, this could potentially lead to the worst case scenario and cause multiple spurious hits.

A spurious hit occurs when the hash value of the pattern matches the hash value of the currently observed sub-string, but when compared they do not match one another.

The hashing function suggested by Rabin-Karp is  
$$p[0]*10^{m-1} + p[1]*10^{m-2} + ... p[m-1]*10^0$$
It should be acknowledged that for larger character sets and larger patterns, this hashing function is vulnerable to integer overflows. To account for this, the modulus of the hashing value can be taken using a prime number.

## Examples

### python

```python
alphabetLength = 256
primeNumber = 16777619

def search(pattern, text):
    patternLength = len(pattern)
    textLength = len(text)
    patternHash = 0
    textHash = 0
    fingerprint = 1
    i = 0
    j = 0
    # setting the fingerprint
    for i in range(patternLength-1):
        fingerprint = (
            fingerprint * alphabetLength
        ) % primeNumber
    # pre-processing pattern and text hash values
    for i in range(patternLength):
        patternHash = (
          alphabetLength * patternHash + ord(pattern[i])
        ) % primeNumber
        textHash = (
          alphabetLength * textHash + ord(text[i])
        ) % primeNumber
    # search the text
    for i in range(textLength - patternLength+1):
        # check the characters manually when hit occurs
        if patternHash == textHash:
            for j in range(patternLength):
                if text[i + j] != pattern[j]:
                    break
            j += 1
            if j == patternLength:
                print("Pattern found at: " + str(i+1))
        # roll the hash forward
        if i < textLength-patternLength:
            textHash = (
              alphabetLength * (
                textHash - ord(text[i]) * fingerprint
              ) + ord(text[i + patternLength])
            ) % primeNumber
            if textHash < 0:
                textHash = textHash + primeNumber
```

### go

```go
func search(pattern, text string) []int {
	results := []int{}
	patternLength := len(pattern)
	textLength := len(text)
	patternHash := 0
	textHash := 0
	fingerprint := 1
	i := 0
	j := 0
	// setting the fingerprint
	for i = 0; i < patternLength - 1; i++ {
		fingerprint = (fingerprint * alphabetLength) % primeNumber
	}
	// pre-processing pattern and text hash values
	for i = 0; i < patternLength; i++ {
		patternHash = (alphabetLength*patternHash +
			int(pattern[i])) % primeNumber
		textHash = (alphabetLength*textHash +
			int(text[i])) % primeNumber
	}
	// search the text
	for i = 0; i <= textLength-patternLength; i++ {
		// check the characters manually when hit occurs
		if patternHash == textHash {
			for j = 0; j < patternLength; j++ {
				if text[i+j] != pattern[j] {
					break
				}
			}
			if j == patternLength {
				results = append(results, i)
			}
		}
		// roll the hash forward
		if i < textLength-patternLength {
			textHash = (alphabetLength * (textHash -
				int(text[i])*fingerprint) +
				int(text[i+patternLength])) % primeNumber
			if textHash < 0 {
				textHash = textHash + primeNumber
			}
		}
	}
	return results
}
```