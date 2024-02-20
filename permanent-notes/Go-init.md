---
tags:
  - idea
aliases:
---

# init()

The `init()` function in go is a function that is initialized first in the
package. The order of evaluation is

1. Constants and variables
2. Dependency `init()`s in alphabetical order
3. Main package `init()`
4. `main()`

## Problems

Error management in `init()` functions is limited since they do not return
errors. The only way to indicate that something has gone wrong in an `init()` is
to panic. This behavior should not be left to the package to decide whether to
stop an application or not.

Testing also becomes a problem with `init()` functions. This function will
always be executed before running test cases which can create complications.

Global variables are also required when `init()` functions are used for
initialization. These introduce a lot of additional downsides as they can be
modified by an function in the package and make it difficult to isolate test
cases.

## References

- [go](/permanent-notes/Go-Programming-Language.md)
