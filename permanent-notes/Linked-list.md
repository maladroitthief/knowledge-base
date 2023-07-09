type: #idea
subject: [Data-Structures](Data-Structures.md)
<!-- Subject should be a hub note -->
# Linked list

Similar to an [Array](Array.md), the linked list is a  sequential data structure that stores elements linearly. Unlike arrays, the order is not determined by it's position in memory, but instead it keeps an address of the next element.

This has the advantage of it being an O(1) operation to insert and delete elements in the linked list. The draw back, however, is that accessing is an O(n) operation as the linked list needs to be traveled to find the element.

| Operation | Big-O |
|-----------|-------|
| Access | O(n) |
| Search | O(n) |
| Insert | O(1) |
| Remove | O(1) |

## Types

### Singly linked list

A linked list where each nodes points to the next node and the last node is addressed to nil.

### Doubly linked list

A linked list where the node has two pointers, next and previous.

### Circular linked list

A linked list that can be either a singly or doubly linked list, with a caveat being the next address at the last node points to the first node or vice versa with the previous address.

## Common practices

- Counting nodes in linked list
- Reversing a linked list in-place
- Finding the middle node
- Merging two linked lists

## Corner cases

- Empty linked list
- Single node
- Two nodes
- Linked list has cycles

## Techniques

### Sentinel nodes

Adding a sentinel node to either the head or tail of a linked list can avoid a wide variety of edge cases. Just this node existing means that operations will never occur on the HEAD or TAIL of the list. These nodes should be removed after processing is finished.

### Two pointers

The [Two-pointers](Two-pointers.md) technique is very common with linked lists. Consider the following:

- Getting the k'th node from the last node
- Cycle detection. Have one pointer increment twice as fast as the other, if they meet it's a cycle.
- Finding the middle node. Have one pointer increment twice as fast as the other. When it reaches the end, the slower pointer is at the middle.

### Using space

Avoid creating an auxiliary linked list to modify an already existing one. Instead, do in-place operations to avoid wasting memory.

---
# References
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
<!-- What references back up this idea -->
