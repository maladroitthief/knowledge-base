---
title: Being puzzled about when to use channels or mutexes
layout: idea
tags:
  - 100-go-mistakes
---

# Being puzzled about when to use channels or mutexes

In Go, channels are a communication mechanism that can be used to send and
receive values. Channels can be either unbuffered, blocks until receiver is
ready, or they can be buffered, blocks when the buffer is full.

For parallel goroutines, a mutex is necessary for synchronization. For
coordination or communication, a channel is necessary.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
