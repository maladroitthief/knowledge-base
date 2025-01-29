---
title: Expecting deterministic behavior using select and channels
layout: idea
tags:
  - 100-go-mistakes
---

# Expecting deterministic behavior using select and channels

## Mistake

Unlike the switch case, select case is random which case will be satisfied
first. If `messageCh` is buffered, even if we had more messages to process on
the `messageCh` when `disconnectCh` receives a message it becomes random which
will be triggered.

```go
for {
  select {
  case v := <-messageCh:
    fmt.Print(v)
  case <- disconnectCh:
    return
  }
}

///////////

for i := 0; i < 10; i++ {
  messageCh <- i
}

disconnectCh <- struct{}{}
```

## Fix

Use an unbuffered channel so that it blocks and guarantees all messages are
delivered. We could also use a single channel instead of two.

If neither of these approaches is possible we can add an inner select:

```go
for {
  select {
  case v := <-messageCh
    fmt.Print(v)
  case <-disconnectCh:
    for {
      select {
        // read the remaining messages and then exit
        case v := <-messageCh:
          fmt.Print(v)
        default:
          return
      }
    }
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
