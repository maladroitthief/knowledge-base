package main

import (
	"io"
	"sync"
	"sync/atomic"
)

func main() {
}

func read(r io.Reader) (int, error) {
	var count int64
	wg := sync.WaitGroup{}
	var n = 10
	ch := make(chan []byte, n)
	wg.Add(n)

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
