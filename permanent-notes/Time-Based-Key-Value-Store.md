type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Time-Based-Key-Value-Store

Design a time-based key-value data structure that can store multiple values for the same key at different time stamps and retrieve the key's value at a certain timestamp.

Implement the `TimeMap` class:

- `TimeMap()` Initializes the object of the data structure.
- `void set(String key, String value, int timestamp)` Stores the key `key` with the value `value` at the given time `timestamp`.
- `String get(String key, int timestamp)` Returns a value such that `set` was called previously, with `timestamp_prev <= timestamp`. If there are multiple such values, it returns the value associated with the largest `timestamp_prev`. If there are no values, it returns `""`.

## Method

Use a map and binary search.

## Solution

### go

```go
type TimeMap struct {
	mv map[string][]Pair
}

type Pair struct{
	value string
	time int
}

func Constructor() TimeMap {
	return TimeMap{
		mv: make(map[string][]Pair),
	}
}

func (this *TimeMap) Set(key string, value string, timestamp int)  {
	pair := Pair{
		value: value,
		time: timestamp,
	}
	
	_, ok := this.mv[key]
	if !ok {
		this.mv[key] = make([]Pair, 0)
	}
	
	this.mv[key] = append(this.mv[key], pair)
}

func (this *TimeMap) Get(key string, timestamp int) string {
	mapVal, ok := this.mv[key]
	if !ok {
		return ""
	}
	
	if mapVal[0].time > timestamp {
		return ""
	}
	
	start, mid, end := 0, 0, len(mapVal)-1
	for start < end {
		mid = (start + end)/2
		if mapVal[mid].time < timestamp {
			start = mid + 1
		} else if mapVal[mid].time > timestamp {
			end = mid - 1
		} else {
			return mapVal[mid].value
		}
	}
	
	if mapVal[start].time > timestamp {
		return mapVal[start-1].value
	}
	return mapVal[start].value
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/time-based-key-value-store/)
