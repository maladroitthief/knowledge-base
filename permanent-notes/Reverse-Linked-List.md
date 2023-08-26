type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Reverse-Linked-List

## Method

Given the `head` of a singly linked list, reverse the list, and return _the reversed list_.

## Solution

Do a three way swap of the values

### go

```go
func reverseList(head *ListNode) *ListNode {
	var prev *ListNode
	for head != nil {
		prev, head, head.Next = head, head.Next, prev
	}
	return prev
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/reverse-linked-list/)
