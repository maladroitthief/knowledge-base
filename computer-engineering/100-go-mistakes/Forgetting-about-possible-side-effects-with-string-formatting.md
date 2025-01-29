---
title: Forgetting about possible side effects with string formatting
layout: idea
tags:
  - 100-go-mistakes
---

# Forgetting about possible side effects with string formatting

## Mistake

```go
func (c *Customer) String() string {
  c.mutex.RLock()
  defer c.mutex.RUnlock()
  return fmt.Sprintf("id %s, age %s", c.id, c.age)
}

func (c *Customer) UpdateAge(age int) error {
  c.mutex.Lock()
  defer c.mutex.Unlock()

  if age < 0 {
    // This creates a deadlock because it will be calling the String() method
    //    through the Stringer interface
    return fmt.Errorf("age should be positive: %v", c)
  }

  c.age = age
  return nil
}
```

## Fix

```go
func (c *Customer) String() string {
  c.mutex.RLock()
  defer c.mutex.RUnlock()
  return fmt.Sprintf("id %s, age %s", c.id, c.age)
}

func (c *Customer) UpdateAge(age int) error {
  if age < 0 {
    return fmt.Errorf("age should be positive: %v", c)
  }

  c.mutex.Lock()
  defer c.mutex.Unlock()

  c.age = age
  return nil
}
```

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
