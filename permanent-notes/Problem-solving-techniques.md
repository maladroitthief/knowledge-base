type: #idea
subject: [Software-Engineering](Software-Engineering.md)
<!-- Subject should be a hub note -->
# Problem solving techniques

When solving unfamiliar problems in software engineering, it is best to take a structured approach when breaking the problem down. In addition, make sure the problem is fully understood by gathering more information and discussing the problem with colleagues.

## Visualize

Use a white board or paper to draw out diagrams or map the problem out state by state. This can prove to be critical when working with [trees](Tree.md), [graphs](Graph.md), [matrices](Matrix.md), and [linked lists](Linked-list.md).

## Manual approach

How could this problem be solved without using code? This is often intuitive, but can be a useful approach if an efficient solution isn't obviously apparent.

## Add additional examples

Coming up with additional examples is helpful for testing your understanding of the problem. It may also present patterns in the input for a problem that can be used for coming up with a solution. These additional examples can also be later used for testing the solution.

## Break the problem down

When dealing with a complex or large problem, consider breaking it apart into smaller steps with the original problem still existing at a high level. This prevents getting overwhelmed by the complexity and adds structure to the approach.

## Data structures & algorithms

Often times, existing data structures or algorithms can make solving a problem trivial.

### [Data structures](Data-Structures.md)

- [Hash table](Hash-table.md): Useful for look ups
- [Graph](Graph.md): Given data with associations between entities
- [Stack](Stack.md) & [Queue](Queue.md): Useful for parsing strings with nested properties
- [Heap](Heap.md): Scheduling or ordering based on priority
- [Tree](Tree.md) & [Trie](Trie.md): Storing or querying strings effieciently

### [Algorithms](Algorithms.md)

- [Sorting-and-searching](Sorting-and-searching.md)
- [Binary-search](Binary-search.md)
- [Sliding-window](Sliding-window.md)
- [Two-pointers](Two-pointers.md)
- [Union-find](Union-find.md)
- [BFS](Breadth-first-search.md)/[DFS](Depth-first-search.md)
- [Traverse-from-right](Traverse-from-right.md)
- [Topological-sorting](Topological-sorting.md)

## Optimize

### Time complexity

1. Identify the best theoretical time complexity of the solution. If it is not possible to beat that time complexity, do not continue trying to optimize.
2. Identify repeated work. Look for opportunities to reuse results of expensive operations. Also consider pre-processing steps that may not be intuitive, but set the problem up to be more efficient.
3. Consider alternative data structures. Some structures may make certain operations like look-ups or sorting trivial due to their design.
4. Avoid redundant work. Don't add a guard clause for a case that can never occur. Terminate earlier if there is no need to continue processing.

### Space complexity

1. Re-use existing variables rather than create new ones when allowed.
2. Consider alternative data structures. Don't use a structure that adds a lot of overhead when there is a simpler option.

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)