type: #idea
subject: [Algorithms](Algorithms.md)
<!-- Subject should be a hub note -->
# Sorting and searching

Sorting is the act of rearranging a sequence in some known order such as numerical or lexicographical that is either ascending or descending. Sorting arrays are valuable as they enable binary searching which is faster than [linear time](Linear-functions.md).

## Complexity

### Sorting

| Algorithm | Time | Space |
|-----------|------|-------|
| Bubble sort | O(n^2) | O(1) |
| Insertion sort | O(n^2) | O(1) |
| Selection sort | O(n^2) | O(1) |
| Quicksort | O(n log(n)) | O(log(n)) |
| Mergesort | O(n log(n)) | O(n) |
| Heapsort | O(n log(n)) | O(1) |
| Counting sort | O(n + k) | O(k) |
| Radix sort | O(nk) | O(n + k) |

### Searching

| Algorithm | Time | 
|-----------|------|
| Binary search | O(log(n)) |

## Edge cases

- Empty sequence
- Sequence with one element
- Sequence with two elements
- Sequence with duplicate elements

---
# References
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
