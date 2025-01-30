---
title: Forgetting about sync.Cond
layout: idea
tags:
  - 100-go-mistakes
---

# Forgetting about sync.Cond


## Mistake

This example works but contains a CPU burner loop. It wastes a lot of cycles
checking if the donation goal has been met. This could be eliminated by using
a shared channel between the two goroutines, but we introduce another problem
where we could surpass our goal for one goroutine while the other goroutine is
using that channel.

```go
type Donation struct {
  mu sync.RWMutex
  balance int
}
donation := &Donation{}

f := func(goal int){
  donation.mu.RLock()
  for donation.balance < goal {
    donation.mu.RUnlock()
    donation.mu.RLock()
  }
  donation.mu.RUnlock()
}
go f(10)
go f(15)

go func(){
  for {
    time.Sleep(time.Second)
    donation.mu.Lock()
    donation.balance++
    donation.mu.Unlock()
  }
}()
```

## Fix

```go
type Donation struct {
  cond *sync.Cond
  balance int
}
donation := &Donation{
  cond: sync.NewCond(&sync.Mutex{}),
}

f := func(goal int){
  donation.cond.L.Lock()
  for donation.balance < goal {
    // blocks until condition is met/broadcast
    // cond.Wait() does the following:
    //  - Unlock the mutex
    //  - Suspend the goroutine until a notification is received
    //  - Lock the mutex
    donation.cond.Wait()
  }
  donation.cond.L.Unlock()
}

go f(10)
go f(15)

for {
  time.Sleep(time.Second)
  donation.cond.L.Lock()
  donation.balance++
  donation.cond.L.Unlock()
  // broadcast that a condition was met
  donation.cond.Broadcast()
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
