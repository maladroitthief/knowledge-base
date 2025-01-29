---
title: Being puzzled about channel size
layout: idea
tags:
  - 100-go-mistakes
---

# Being puzzled about channel size

An unbuffered channel, or a synchronous channel, has a size of zero and blocks.
A buffered channel, or asynchronous channel, has some size and is unblocking
until it becomes full.

For worker-pool patterns, the channel size should be the same as the number of
workers. For rate-limiting, the channel size should be set in accordance to the
resource we are limited by.

Outside of these use-cases, using a different channel size should be done with
caution and should likely include a comment on the rationale behind that number.
The smaller the value, the more CPU contention we can handle. The larger the
number, the more memory we need to allocate.

When in doubt, start with a default size of 1.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
