---
title: Not understanding the concurrency impacts of a workload type
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding the concurrency impacts of a workload type

The execution time of a workload is limited by one of the following:

- CPU speed: CPU bound
- I/O speed: I/O bound
- Available memory: Memory bound

## Mistake

How do we parallelize this task?

```go
func read(r io.Reader) (int, error) {
	count := 0

	for {
		b := make([]byte, 1024)
		_, err := r.Read(b)

		if err != nil {
			if err == io.EOF {
				break
			}
			return 0, err
		}

		count += task(b)
	}

	return count, nil
}

```

## Fix

### Worker-pooling pattern

```go
func read(r io.Reader) (int, error) {
	var count int64
	wg := sync.WaitGroup{}

  // What we set `n` to largely is based on whether the task is IO or CPU bound
  // For I/O bound tasks, n should be some value that the system can handle.
  //    Some trial and error may be necessary to determine this value.
  // For CPU bound tasks, use GOMAXPROCS:
  //    n := runtime.GOMAXPROCS(0)
	var n = 10

  // Buffered channel and wait group are the same size
	ch := make(chan []byte, n)
	wg.Add(n)

  // Create n goroutines
	for i := 0; i < n; i++ {
		go func() {
			defer wg.Done()

			for b := range ch {
				v := task(b)
				atomic.AddInt64(&count, int64(v))
			}
		}()
	}

	for {
		b := make([]byte, 1024)
		// Read from r to b
		ch <- b
	}

	close(ch)
	wg.Wait()

	return int(count), nil
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
