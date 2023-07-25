type: #idea
subject: [Data-Structures](Data-Structures.md)
<!-- Subject should be a hub note -->
# Heap

A heap is a [Tree](Tree.md) data structure that is complete, or every level is full.

- **Max heap**: A heap where the value of the node is the greatest value in that node's sub-tree. This must be true for all nodes in the heap
- **Min heap**: A heap where the value of the node in the smallest value in that node's sub-tree. This must be true for all nodes in the heap

Heaps can be valuable when it is necessary to remove nodes with either the highest or lowest priority or when inserts are mixed with removals of the root node.

| Operation | Big-O |
|-----------|-------|
| Find max/min | O(1) |
| Insert | O(log(n)) |
| Remove | O(log(n)) |
| Create | O(n) |

## Examples

### go

Using the [heap package](https://pkg.go.dev/container/heap)

```go
type Heap []int

func (h Heap) Len() int {
	return len(h)	
}

func (h Heap) Less(i int, j int) bool {
	return h[i] < h[j]
}

func (h Heap) Swap(i int, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *Heap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *Heap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)