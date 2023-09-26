type: #idea
subject: [Data-Structures](Data-Structures.md)

<!-- Subject should be a hub note -->

# String

Strings are character arrays and share a lot of similarities with [arrays](Array.md) as shown in their relative time complexity.

| Operation | Big-O |
| --------- | ----- |
| Access    | O(1)  |
| Search    | O(n)  |
| Insert    | O(n)  |
| Remove    | O(n)  |

## Common data-structures for looking up strings

- [Prefix Tree](Prefix-tree.md)
- [Suffix Tree](Suffix-tree.md)

## Common string algorithms

- [Rabin Karp](Rabin-Karp.md) for sub-string searching
- [KMP](KMP.md) for sub-string searching

## Multi-string operations

| Operation       | Big-O     | Note                                                   |
| --------------- | --------- | ------------------------------------------------------ |
| Find sub-string | O(n \* m) | Most naive case. KMP and Rabin Karp are more efficient |
| Concatenate     | O(n + m)  |                                                        |
| Slice           | O(m)      |                                                        |
| Split           | O(n + m)  | Split by using some character token                    |
| Strip           | O(n)      | Remove leading and trailing whitespace                 |

## Common edge cases

- Empty string
- String with 1 or 2 characters
- String with repeated characters or sub-strings
- Strings with only distinct or no repeating characters

## Techniques

### Counting Characters

When counting the frequency of characters or a pattern in a string, use a hash map.

### Anagram

To determine if two strings are anagrams of one another, sort them and compare the resulting string.

### Palindrome

To determine if a string is a palindrome, reverse it and compare the two strings. It is also possible to use two pointers at either end of the string and move them inward, comparing character by character until they meet.

