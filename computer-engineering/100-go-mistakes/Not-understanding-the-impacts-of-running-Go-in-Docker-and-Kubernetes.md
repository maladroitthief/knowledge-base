---
title: Not understanding the impacts of running Go in Docker and Kubernetes
layout: idea
tags:
  - 100-go-mistakes
---

# Not understanding the impacts of running Go in Docker and Kubernetes

It is important to understand the implications of running Go in
Docker/Kubernetes to prevent common situations such as CPU throttling. The
environment variable `GOMAXPROCS` defines the limit of OS threads in charge of
executing user-level code simultaneously. This defaults to the number of OS
logical CPU cores. Consider the following Kubernetes spec:

```yaml
spec:
  containers:
    - name: app
      image: app
      resources:
        limits:
          cpu: 4000m # 4 CPU cores
```

We would expect `GOMAXPROCS` to have a value of 4, but in this case it doesn't.
It is set to 8 which is the number of cores on the host machine. With Kubernetes
Completely Fair Scheduler (CFS) our pod is given a budget of CPU time. In this
case, if we were using 8 threads at max capacity when our CPU resource limit was
defined as 4 cores we would have our application throttled half the time. At the
time this remains an open issue in Go, but can be solved with an import in
main.go:

```go
import _ "go.uber.org/automaxprocs"
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
