type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Implement-Queue-using-Stacks

Implement a first in first out (FIFO) queue using only two stacks. The implemented queue should support all the functions of a normal queue (`push`, `peek`, `pop`, and `empty`).

Implement the `MyQueue` class:

- `void push(int x)` Pushes element x to the back of the queue.
- `int pop()` Removes the element from the front of the queue and returns it.
- `int peek()` Returns the element at the front of the queue.
- `boolean empty()` Returns `true` if the queue is empty, `false` otherwise.

**Notes:**

- You must use **only** standard operations of a stack, which means only `push to top`, `peek/pop from top`, `size`, and `is empty` operations are valid.
- Depending on your language, the stack may not be supported natively. You may simulate a stack using a list or deque (double-ended queue) as long as you use only a stack's standard operations.

## Method

Keep one stack for reading and the other for writing. Do not forget to completely drain the read stack before writing pushing more values to it.

## Solution

### go

```go
type MyQueue struct {
	pushStack *list.List
	popStack *list.List
}
func Constructor() MyQueue {
	return MyQueue{
		pushStack: list.New(),
		popStack: list.New(),
	}
}
func (this *MyQueue) Push(x int) {
	this.pushStack.PushBack(x)
}
func (this *MyQueue) Pop() int {
	result := this.Peek()
	this.popStack.Remove(this.popStack.Back())
	return result
}
func (this *MyQueue) Peek() int {
	if this.popStack.Len() != 0 {
		return this.popStack.Back().Value.(int)
	}
	for this.pushStack.Len() > 0 {
		this.popStack.PushBack(
			this.pushStack.Remove(this.pushStack.Back()),
		)
	}
	return this.popStack.Back().Value.(int)
}
func (this *MyQueue) Empty() bool {
	return this.pushStack.Len() == 0 && this.popStack.Len() == 0
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/implement-queue-using-stacks)