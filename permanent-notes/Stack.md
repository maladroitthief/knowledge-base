---
tags:
 - idea
aliases:
---

# Stack

A stack is a linear data structure that supports adding elements to one end and removing elements from that same end.

| Operation | Big-O |
|-----------|-------|
| Top/Peek | O(1) |
| Push | O(1) |
| Pop | O(1) |
| Search | O(n) |
| isEmpty | O(1) |

## Examples

### go

For short lived stacks

```go
var stack []string
// Push
stack = append(stack, "Hello")
// Peek
fmt.Print(stack[len(stack)-1])
// Pop
stack = stack[:len(stack)-1]
```

For long lived stacks

```go
stack := list.New()
// Push
stack.PushBack("Hello")
// Peek
stack.Back()
// Pop
stack.Remove(stack.Back())
```

## References

- [Data-Structures](Data-Structures.md)
- [Tech-Interview-Handbook](Tech-Interview-Handbook.md)
