---
title: Cache
layout: idea
tags:
  - performance
  - computer-engineering
---

# Cache

- load and store is how a CPU gets and puts things into memory
  - analogous to read and write
- loads are very importance when it comes to analyzing the performance of the
  CPU
- main memory is very slow compared to the CPU circuitry
- to offset this, the CPU uses a layered cache
- L1 Cache
  - Very fast & efficient (3-4 cycles to load)
  - Very small (~32kB)
- L2 Cache
  - Pretty fast (~10-12 cycles to load)
  - Medium (~256kB)
- L3 Cache
  - Fast (~30-70 cycles to load)
  - Large (~8MB)
- Main Memory
  - Slow (~100-150 cycles to load)
  - Very Large (~16GB)

- modern CPUs are multi-core
- each core will have it's own L1, L2
- the L3 is shared across cores

- the performance penalty from not considering the cache can undo all other
  performance improvements
