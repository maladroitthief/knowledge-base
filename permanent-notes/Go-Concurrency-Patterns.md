---
tags:
 - idea
aliases:
---

# Go-Concurrency-Patterns

## Pipeline

A series of stages connected by channels. 

```go
func gen(nums ...int) <-chan int{
	out := make(chan int, len(nums))
	for _, n := range nums{
		out <- n
	}
	close(out)
	return out
}

func square(in <-chan int) <-chan int{
	out := make(chan int)
	go func(){
		for n := range in {
			out <- n * n
		}
		close(out)
	}()
	return out
}

func main(){
	c := gen(2, 3, 4)
	out := square(c)
	for n := range c {
		fmt.Println(n)
	}
}
```

## Fan out, fan in

Multiple functions reading from the same channel until that channel is closed. This enables a method to distribute work to a group of workers to parallel CPU usage and I/O. Fan in is the merging the results of those workers.

```go
// Stage 1
func gen(nums ...int) <-chan int{
	out := make(chan int, len(nums))
	defer close(out)
	for _, n := range nums{
		select{
		case out <- n:
		case <-done:
			return out
		}
	}
}
// Stage 2
func square(in <-chan int) <-chan int{
	out := make(chan int)
	go func(){
		defer close(out)
		for n := range in {
			select {
			case out <- n * n:
			case <-done:
				return
			}
		}
	}()
	return out
}
// Stage 3
func merge (done <-chan struct{}, cs ...<-chan int) <-chan int{
	var wg sync.WaitGroup
	out := make(chan int)
	// Copy from c to out and mark done when it c closes
	output := func(c <-chan int){
		defer wg.Done()
		for n := range c {
			select{
			case out <- n:
			case <-done:
				return
			}
		}
	}
	// Start a goroutine for every channel in cs
	wg.Add(len(cs))
	for _, c := range cs {
		go output(c)
	}
	// Close out when all other goroutines have finished
	go func() {
		wg.Wait()
		close(out)
	}
	return out
}

func main(){
	// create shared done channel
	// close it when the pipeline exits
	done := make(chan struct{})
	defer close(done)
	
	in := gen(done, 2, 4)
	// distribute work between two goroutines
	c1 := square(done, in)
	c2 := square(done, in)
	// consume first output
	out := merge(done, c1, c2)
	fmt.Println(<-out)
}
```

## References

- [Go-Programming-Language](Go-Programming-Language.md)
