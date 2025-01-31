---
title: Not dealing with the time API efficiently
layout: idea
tags:
  - 100-go-mistakes
---

# Not dealing with the time API efficiently


## Mistake

### Implementation

```go
type Cache struct {
  mu sync.RWMutex
  events []Event
}

type Event struct {
  Timestamp time.Time
  Data string
}

func (c *Cache) TrimOlderThan(since time.Duration) {
  c.mu.Lock()
  defer c.mu.Unlock()

  // this is very difficult to test
  t := time.Now().Add(-since)
  for i := 0; i < len(c.events); i++ {
    if c.events[i].Timestamp.After(t) {
      c.events = c.events[i:]
      return
    }
  }
}
```

### Test

```go
func TestCache_TrimOlderThan(t *testing.T) {
  // if the machine becomes busy, we could easily miss this window
  events := []Event{
    {Timestamp: time.Now().Add(-20 * time.Millisecond)},
    {Timestamp: time.Now().Add(-10 * time.Millisecond)},
    {Timestamp: time.Now().Add(10 * time.Millisecond)},
  }

  cache := &Cache{}
  cache.Add(events)
  cache.TrimOlderThan(15 * time.Millisecond)
  got := cache.GetAll()
  want := 2

  if len(got) != want {
    t.Fatalf("want: %d, got: %d", want, len(got))
  }
}
```

## Fix

### Function type

```go
type now func() time.Time

type Cache struct {
  mu sync.RWMutex
  events []Event
  now now
}

func NewCache() *Cache {
  return &Cache{
    events: make([]Event, 0),
    now: time.Now,
  }
}

// ...

func TestCache_TrimOlderThan(t *testing.T) {
  events := []Event{
    {Timestamp: parseTime(t, "2020-01-01T12:00:00.04Z")},
    {Timestamp: parseTime(t, "2020-01-01T12:00:00.05Z")},
    {Timestamp: parseTime(t, "2020-01-01T12:00:00.06Z")},
  }

  cache := &Cache{now: func() time.Time{
    return parseTime(t, "2020-01-01T12:00:00.06Z")
  }}
  cache.Add(events)
  cache.TrimOlderThan(15 * time.Millisecond)

  // ...

  func parseTime(t *testing.T, timestamp string) time.Time {
    // ...
  }
}
```

Even better is to remove the `time.Duration` from the parameter

```go
func (c *Cache) TrimOlderThan(t time.Time) {
  // ...
}

// ...

cache.TrimOlderThan(time.Now().Add(time.Second))
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
