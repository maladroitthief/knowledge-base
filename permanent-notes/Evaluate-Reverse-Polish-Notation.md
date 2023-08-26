type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Evaluate-Reverse-Polish-Notation

You are given an array of strings `tokens` that represents an arithmetic expression in a [Reverse Polish Notation](http://en.wikipedia.org/wiki/Reverse_Polish_notation).

Evaluate the expression. Return _an integer that represents the value of the expression_.

**Note** that:

- The valid operators are `'+'`, `'-'`, `'*'`, and `'/'`.
- Each operand may be an integer or another expression.
- The division between two integers always **truncates toward zero**.
- There will not be any division by zero.
- The input represents a valid arithmetic expression in a reverse polish notation.
- The answer and all the intermediate calculations can be represented in a **32-bit** integer.

## Method

Stack

## Solution

### go

```go
func evalRPN(tokens []string) int {
	stack := []int{}
	var result int
	for _, token := range tokens {
		switch token {
			case "+":
				result = stack[len(stack) - 2] + stack[len(stack) - 1]
				stack = stack[:len(stack)-2]
				stack = append(stack, result)
			case "-":
				result = stack[len(stack) - 2] - stack[len(stack) - 1]
				stack = stack[:len(stack)-2]
				stack = append(stack, result)
			case "*":
				result = stack[len(stack) - 2] * stack[len(stack) - 1]
				stack = stack[:len(stack)-2]
				stack = append(stack, result)
			case "/":
				result = stack[len(stack) - 2] / stack[len(stack) - 1]
				stack = stack[:len(stack)-2]
				stack = append(stack, result)
			default:
				num, _ := strconv.Atoi(token)
				stack = append(stack, num)
		}
	}
	return stack[len(stack)-1]
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/evaluate-reverse-polish-notation/)
