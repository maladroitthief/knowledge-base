type: #idea
subject: [Data-Structures](Data-Structures.md)
<!-- Subject should be a hub note -->
# Queue

A linear data structure that is modified by adding elements to one end and removing them from the other. 

| Operation | Big-O |
|-----------|-------|
| Enqueue | O(1) |
| Dequeue | O(1) |
| Front | O(1) |
| Back | O(1) |
| isEmpty | O(1) |

---

## Examples

### go

For short lived queues, the following approach can be taken. Since the memory for the slice is never returned, memory leaks may occur in long living queues.

```go
var queue []string
// Enqueue
queue = append(queue, "Hello")
// Dequeue
queue = queue[1:]
// Front
fmt.Print(queue[0])
// Back
fmt.Print(queue[len(queue)-1])
```

For long lived queues, a linked list is more appropriate. The `container/list` package provides a doubly linked list.

```go
queue := list.New()
// Enqueue
queue.PushBack("Hello")
// Dequeue
queue.Remove(queue.Front())
// Front
queue.Front()
// Back
queue.Back()
```

# References

[Tech-Interview-Handbook](Tech-Interview-Handbook.md)