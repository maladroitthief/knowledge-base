type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Min-Stack

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

Implement the `MinStack` class:

- `MinStack()` initializes the stack object.
- `void push(int val)` pushes the element `val` onto the stack.
- `void pop()` removes the element on the top of the stack.
- `int top()` gets the top element of the stack.
- `int getMin()` retrieves the minimum element in the stack.

You must implement a solution with `O(1)` time complexity for each function.

## Method

Use a linked list that tracks the minimum

## Solution

### go

```go
type MinStack struct {
	head *stackNode
}

type stackNode struct {
	val int
	min int
	next *stackNode
}

func Constructor() MinStack {
	return MinStack{}
}


func (this *MinStack) Push(val int)  {
	node := &stackNode{
		val: val,
	}
	
	if this.head == nil {
		node.min = val
		this.head = node
		return
	}
	
	node.min = min(val, this.head.min)
	node.next = this.head
	this.head = node
}


func (this *MinStack) Pop() {
	this.head = this.head.next
}


func (this *MinStack) Top() int {
	return this.head.val
}


func (this *MinStack) GetMin() int {
	return this.head.min
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/min-stack/)
