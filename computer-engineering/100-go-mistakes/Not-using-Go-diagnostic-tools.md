---
title: Not using Go diagnostic tools
layout: idea
tags:
  - 100-go-mistakes
---

# Not using Go diagnostic tools

## Profiling

The following profiles can be collected from the go profiler, **pprof**:

- **CPU**: where the application spends its time
- **Goroutine**: stack traces of the ongoing goroutines
- **Heap**: heap memory allocations to monitor usage and check for leaks
- **Mutex**: lock contentions to see mutex behavior and check if we are spending
  too much time in locking calls
- **Block**: where goroutines block waiting on sync primitives

### Enabling pprof

We can expose the data using the `net/http/pprof` package at the url
`http://localhost/debug/pprof`. This can even be used in
[production](https://go.dev/doc/diagnostics#profiling). The profiles that impact
performance are active for just short periods and must be enabled by default.

```go
package main

import (
  "fmt"
  "log"
  "net/http"
  _ "net/http/pprof" // import to pprof
)

func main() {
  // endpoint
  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "")
  })
  log.Fatal(http.ListenAndServe(":80", nil))
}
```

### CPU profiling

When active, the application asks the OS to interrupt it ever 10ms using the
`SIGPROF` signal. When that signal is received, it suspends current activity and
transfers execution to the profiler. After data is collected the profiler stops
and execution is resumed until the next signal. We can access this endpoint at
`http://localhost/debug/pprof/profile`. By default, this runs for 30 seconds but
this can be manipulated using query parameters:
`http://localhost/debug/pprof/profile?seconds=15`.

CPU profiling can also be done during benchmark tests:

```bash
go test -bench=. -cpuprofile profile.out
```

Afterwards the results can be viewed:

```bash
go tool pprof -http=:8080 <filename>
```

The web interface will then show a call graph from the profile results where we
can start making insights. Some common things to consider:

- Wider arrows indicate hotter code paths
- We can see the percent breakdown and duration each function was running for
  the profile run-time (30 seconds by default)
- Calling `runtime.mallogc` often means excessive small heap allocations
- Excessive time spent in channel operations or mutex locks can mean too much
  contention
- Long time spent on `syscall.Read` or `syscall.Write` means the application is
  spending significant time in Kernel mode. Improving I/O buffering could
  improve this

We can also attach labels to functions to track to the total time spent in that
function using `pprof.Labels`.

### Heap profiling

Heap profiling allows us to get metrics on current heap usage. We can access
this profiler at `http://localhost/debug/pprof/heap/?debug=0`. There are a few
different sample types:

- **alloc_objects**: total number of allocated objects
- **alloc_space**: total amount of allocated memory
- **inuse_objects**: number of allocated objects that are unreleased
- **inuse_space**: amount of memory allocated that is unreleased

We can also use the heap profiler to track down memory leaks:

1. Visit `http://localhost/debug/pprof/heap?gc=1` to trigger a GC and download
   the heap profile
2. Wait a few seconds/minutes
3. Visit `http://localhost/debug/pprof/heap?gc=1` to trigger a GC and download
   another heap profile
4. Compare the two profiles

```bash
go tool pprof -http=:8080 -diff_base <file2> <file1>
```

This process can be repeated more times if necessary, but the key is in looking
for steady increases in allocations for a specific object.

### Goroutines profiling

The goroutine profile reports the stack trace of all current goroutines in the
application. This can be downloaded at
`http://localhost/debug/pprof/goroutine/?debug=0`. This is more used for
observing potential goroutine leaks.

### Block profiling

The block profile reports where ongoing goroutines block waiting on sync
primitives.

- Send/receive on unbuffered channel
- Send to full channel
- Receive from empty channel
- Mutex contention
- Network of filesystem wait

We can also see how long a goroutine has been waiting with block profiling to
determine if performance is actually being impacted. We can access this profile
at `http://localhost/debug/pprof/block`, however this is not enabled by default.
We need to call `runtime.SetBlockProfileRate` in order to enable it.

It is critical to understand that once this is enabled, it will be collecting
data in the background even when that endpoint is not being accessed.

### Mutex profiling

The mutex profile reports mutex related blocking. It can be accessed through
`http://localhost/debug/pprof/mutex`. It is also disabled by default and needs
to be enabled using `runtime.SetMutexProfileFraction` which controls the
fraction of mutex contention events reported.

## Execution tracer

The execution tracer is a tool that captures a variety of run-time events and
uses `go tool` to make them observable. It can assist with:

- Understanding runtime events like the performance of GC
- Understanding how goroutines execute
- Identifying poorly parallelized execution

We can access traces either in benchmarks:

```bash
go test -bench=. -v -trace=trace.out
```

Or through the web interface: `http://localhost/debug/pprof/trace?debug=0`. We
can observe the trace using `go tool`:

```bash
go tool trace trace.out
```

Observing many small goroutines with a lot of empty space inbetween them is a
sign of poor parallelization. This means that the orchestrator is spending a lot
of CPU time spinning up and coordinating goroutines instead of the application
running. Less empty space means more efficient CPU utilization and better
performance.

We can also trace to get function insights.

```go
var v int64

// Trace task 1
ctx, fibTask := trace.NewTask(context.Background(), "fibonacci")
trace.WithRegion(ctx, "main", func() {
  v = fibonacci(10)
})
fibTask.End()

// Trace task 2
ctx, fibStore := trace.NewTask(ctx, "store")
trace.WithRegion(ctx, "main", func() {
  atomic.StoreInt64(&result, v)
})
fibStore.End()
```

This is different from CPU profiling. CPU profiling is sample based, per
function, and does not go below the sample rate (default 10 ms). User-level
traces aren't sample based, per goroutine execution, and are not bounded by any
rate.

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
