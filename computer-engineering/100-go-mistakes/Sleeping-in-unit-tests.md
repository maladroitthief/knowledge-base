---
title: Sleeping in unit tests
layout: idea
tags:
  - 100-go-mistakes
---

# Sleeping in unit tests


## Mistake

### Implementation

```go
type Handler struct {
  n int
  publisher publisher
}

type publisher interface {
  Publish([]Foo)
}

func (h Handler) getBestFoo(someInputs int) Foo {
  foos := getFoos(someInputs)
  best := foos[0]

  go func() {
    if len(foos) > h.n {
      foos = foos[:h.n]
    }

    h.publisher.Publish(foos)
  }()

  return best
}
```
### Test

```go
type publisherMock struct {
  mu sync.RWMutex
  got []Foo
}

func (p *publisherMock) Publish(got []Foo){
  p.mu.Lock()
  defer p.mu.Unlock()

  p.got = got
}

func (p *publisherMock) Get() []Foo {
  p.mu.Lock()
  defer p.mu.Unlock()

  return p.got
}

func TestGetBestFoo(t *testing.T) {
  mock := publisherMock{}
  h := Handler{
    publisher: &mock,
    n: 2,
  }

  foo := h.getBestFoo(42)

  // this is very flaky, there is no guarantee this will be enough time
  time.Sleep(10 * time.Millisecond)

  published := mock.Get()
}
```

## Fix

Use channels

```go
type publisherMock struct {
  ch chan []Foo
}

func (p *publisherMock) Publish(got []Foo) {
  p.ch <- got
}

func TestGetBestFoo(t *testing.T) {
  mock := publisherMock {
    ch: make(chan []Foo)
  }
  defer close(mock.ch)

  h := Handler{
    publisher: &mock,
    n: 2,
  }

  foo := h.getBestFoo(42)

  v := len(<-mock.ch)
  if v != 2 {
    t.Fatalf("expected 2, got: %d", v)
  }
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
