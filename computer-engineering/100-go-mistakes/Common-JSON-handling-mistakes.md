---
title: Common JSON handling mistakes
layout: idea
tags:
  - 100-go-mistakes
---

# Common JSON handling mistakes

## Type embedding

### Mistake

This does not work because time.Time implements the `json.Marshaler` interface
and will clobber any sort of JSON marshaling we are trying to accomplish.

```go
type Event struct {
  ID int
  time.Time // embedded field
}

event := Event{
  ID: 123456,
  Time: time.Now(),
}

b, err := json.Marshal(event)
if err != nil {
  return err
}
```

### Fix

```go
type Event struct {
  ID: int
  Time: time.Time
}
```

Alternatively we could chose to implement the `json.Marshaler` interface

```go
func (e *Event) MarshalJSON() ([]byte, error){
  return json.Marshal(
    // leveraging an anonymous struct
    struct {
      ID int
      Time time.Time
    }{
      ID: e.ID,
      Time: e.Time,
    },
  )
}
```

## The monotonic clock

An OS handles two types of clocks:

- Wall: measuring the time of day
- Monotonic: measuring duration

### Mistake

```go
type Event struct {
  Time time.Time
}

t := time.Now()
event1 := Event{
  Time: t,
}

b, err := json.Marshal(event1)
if err != nil {
  return
}

var event2 Event
err = json.Unmarshal(b, &event2)
if err != nil {
  return
}

assert(event1 == event2)
```

This assertion will fail. This is because `time.Time` handles both monotonic and
wall clocks.

> 2021-01-10 17:13:08.852061 +0100 CET m=+0.000338660
>
> ---
>
> Wall time Monotonic time

### Fix

```go
event1.Time.Equal(event2.Time)
```

Alternatively we can strip away the monotonic time.

```go
t := time.Now()
event := Event{
  Time: t.Truncate(0),
}
```

## Map of any

This code works, however it should be made clear that any numeric field will be
assigned to a `float64` regardless whether it contains a decimal point or not.

```go
b := getMessage()
var m map[string]any

err := json.Unmarshal(b, &m)
if err != nil {
  return err
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
