---
tags:
 - idea
aliases:
---

# Prefix tree

An implementation of a [Trie](Trie.md) but instead of holding characters on the edges, we instead hold sub-strings of the inserted string going from left to right.

## Examples

### go

```go
type TrieNode struct {
	children    map[rune]*TrieNode
	isLeaf bool
}

func NewTrieNode() *TrieNode {
	tn := &TrieNode{
		children:    make(map[rune]*TrieNode),
		isLeaf: false,
	}
	return tn
}

type Trie struct {
	root *TrieNode
}

func NewTrie() *Trie {
	t := &Trie{
		root: NewTrieNode(),
	}
	return t
}

func (t *Trie) Insert(key string) {
	current := t.root
	for _, index := range key {
		_, ok := current.children[index]
		if !ok {
			current.children[index] = NewTrieNode()
		}
		current = current.children[index]
	}
	current.isLeaf = true
}

func (t *Trie) Search(key string) bool {
	current := t.root
	for _, index := range key {
		_, ok := current.children[index]
		if !ok {
			return false
		}
		current = current.children[index]
	}
	return current.isLeaf
}

func (t *Trie) Prefix(key string) bool {
	current := t.root
	for _, index := range key {
		_, ok := current.children[index]
		if !ok {
			return false
		}
		current = current.children[index]
	}
	return true
}
```

## References

- [Data-Structures](Data-Structures.md)
