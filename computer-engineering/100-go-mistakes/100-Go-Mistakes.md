---
title: 100 Go Mistakes
layout: idea
tags:
  - 100-go-mistakes
  - computer-engineering
---

# 100 Go Mistakes

Go is a programming language that is simple to learn but difficult to master.

## Organization

- [Variable shadowing](/computer-engineering/100-go-mistakes/Variable-shadowing)
- [Unnecessary Nested Code](/computer-engineering/100-go-mistakes/Unnecessary-nested-code)
- [Misusing init functions](/computer-engineering/100-go-mistakes/Misusing-init-functions)
- [Overusing getters and setters](/computer-engineering/100-go-mistakes/Overusing-getters-and-setters)
- [Interface pollution](/computer-engineering/100-go-mistakes/Interface-pollution)
- [Interface on the producer side](/computer-engineering/100-go-mistakes/Interface-on-the-producer-side)
- [Returning interfaces](/computer-engineering/100-go-mistakes/Returning-interfaces)
- [Any says nothing](/computer-engineering/100-go-mistakes/Any-says-nothing)
- [Being confused about when to use generics](/computer-engineering/100-go-mistakes/Being-confused-about-when-to-use-generics)
- [Not being aware of the possible problems with type embedding](/computer-engineering/100-go-mistakes/Not-being-aware-of-the-problems-with-type-embedding)
- [Not using the functional options pattern](/computer-engineering/100-go-mistakes/Not-using-the-functional-options-pattern)
- [Project disorganization](/computer-engineering/100-go-mistakes/Project-disorganization)
- [Creating utility packages](/computer-engineering/100-go-mistakes/Creating-utility-packages)
- [Ignoring package name collisions](/computer-engineering/100-go-mistakes/Ignoring-package-name-collisions)
- [Missing code documentation](/computer-engineering/100-go-mistakes/Missing-code-documentation)
- [Not using linters](/computer-engineering/100-go-mistakes/Not-using-linters)

## Data types

- [Creating confusion with octal literals](/computer-engineering/100-go-mistakes/Creating-confusion-with-octal-literals)
- [Neglecting integer overflows](/computer-engineering/100-go-mistakes/Neglecting-integer-overflows)
- [Not understanding floating points](/computer-engineering/100-go-mistakes/Not-understanding-floating-points)
- [Not understanding slice length and capacity](/computer-engineering/100-go-mistakes/Not-understanding-slice-length-and-capacity)
- [Inefficient slice initialization](/computer-engineering/100-go-mistakes/Inefficient-slice-initialization)
- [Being confused about nil and the empty slice](/computer-engineering/100-go-mistakes/Being-confused-about-nil-and-the-empty-slice)
- [Not properly checking if a slice is empty](/computer-engineering/100-go-mistakes/Not-properly-checking-if-a-slice-is-empty)
- [Not making slice copies correctly](/computer-engineering/100-go-mistakes/Not-making-slice-copies-correctly)
- [Unexpected side effects of using slice append](/computer-engineering/100-go-mistakes/Unexpected-side-effects-using-slice-append)
- [Slices and memory leaks](/computer-engineering/100-go-mistakes/Slices-and-memory-leaks)
- [Inefficient map initialization](/computer-engineering/100-go-mistakes/Inefficient-map-initialization)
- [Maps and memory leaks](/computer-engineering/100-go-mistakes/Maps-and-memory-leaks)
- [Comparing values incorrectly](/computer-engineering/100-go-mistakes/Comparing-values-incorrectly)

## Control structures

- [Ignoring the fact that elements are copied in range loops](/computer-engineering/100-go-mistakes/Ignoring-the-fact-that-elements-are-copied-in-range-loops)
- [Ignoring how arguments are evaluated in range loops](/computer-engineering/100-go-mistakes/Ignoring-how-arguments-are-evaluated-in-range-loops)
- [Ignoring the impact of using pointer elements in range loops](/computer-engineering/100-go-mistakes/Ignoring-the-impact-of-using-pointer-elements-in-range-loops)
- [Making wrong assumptions during map iterations](/computer-engineering/100-go-mistakes/Making-wrong-assumptions-during-map-iterations)
- [Ignoring how the break statement works](/computer-engineering/100-go-mistakes/Ignoring-how-the-break-statement-works)
- [Using a defer inside a loop](/computer-engineering/100-go-mistakes/Using-a-defer-inside-a-loop)

## Strings

- [Not understanding the concept of a rune](/computer-engineering/100-go-mistakes/Not-understanding-the-concept-of-a-rune)
- [Inaccurate string iteration](/computer-engineering/100-go-mistakes/Inaccurate-string-iteration)
- [Misusing trim functions](/computer-engineering/100-go-mistakes/Misusing-trim-functions)
- [Under-optimized string concatenation](/computer-engineering/100-go-mistakes/Under-optimized-string-concatenation)
- [Useless string conversions](/computer-engineering/100-go-mistakes/Useless-string-conversions)
- [Substrings and memory leaks](/computer-engineering/100-go-mistakes/Substrings-and-memory-leaks)

## Functions and methods

- [Not knowing which type of receiver to use](/computer-engineering/100-go-mistakes/Not-knowing-which-type-of-receiver-to-use)
- [Never using named result parameters](/computer-engineering/100-go-mistakes/Never-using-named-result-parameters)
- [Unintended side effects with named result parameters](/computer-engineering/100-go-mistakes/Unintended-side-effects-with-named-result-parameters)
- [Returning a nil receiver](/computer-engineering/100-go-mistakes/Returning-a-nil-receiver)
- [Using a filename as a function input](/computer-engineering/100-go-mistakes/Using-a-filename-as-a-function-input)
- [Ignoring how defer arguments and receivers are evaluated](/computer-engineering/100-go-mistakes/Ignoring-how-defer-arguments-and-receivers-are-evaluated)

## Error management

- [Panicking](/computer-engineering/100-go-mistakes/Panicking)
- [Ignoring when to wrap an error](/computer-engineering/100-go-mistakes/Ignoring-when-to-wrap-an-error)
- [Checking an error type inaccurately](/computer-engineering/100-go-mistakes/Checking-an-error-type-inaccurately)
- [Checking an error value inaccurately](/computer-engineering/100-go-mistakes/Checking-an-error-value-inaccurately)
- [Handling an error twice](/computer-engineering/100-go-mistakes/Handling-an-error-twice)
- [Not handling an error](/computer-engineering/100-go-mistakes/Not-handling-an-error)
- [Not handling defer errors](/computer-engineering/100-go-mistakes/Not-handling-defer-errors)

## Concurrency

- [Mixing up concurrency and parallelism](/computer-engineering/100-go-mistakes/Mixing-up-concurrency-and-parallelism)
- [Thinking concurrency is always faster](/computer-engineering/100-go-mistakes/Thinking-concurrency-is-always-faster)
- [Being puzzled about when to use channels or mutexes](/computer-engineering/100-go-mistakes/Being-puzzled-about-when-to-use-channels-or-mutexes)
- [Not understanding race problems](/computer-engineering/100-go-mistakes/Not-understanding-race-problems)
- [Not understanding the concurrency impacts of a workload type](/computer-engineering/100-go-mistakes/Not-understanding-the-concurrency-impacts-of-a-workload-type)
- [Misunderstanding Go contexts](/computer-engineering/100-go-mistakes/Misunderstanding-Go-contexts)
- [Propagating an inappropriate context](/computer-engineering/100-go-mistakes/Propagating-an-inappropriate-context)
- [Starting a goroutine without knowing when to stop it](/computer-engineering/100-go-mistakes/Starting-a-goroutine-without-knowing-when-to-stop-it)
- [Not being careful with goroutines and loop variables](/computer-engineering/100-go-mistakes/Not-being-careful-with-goroutines-and-loop-variables)
- [Expecting deterministic behavior using select and channels](/computer-engineering/100-go-mistakes/Expecting-deterministic-behavior-using-select-and-channels)
- [Not using notification channels](/computer-engineering/100-go-mistakes/Not-using-notification-channels)
- [Not using nil channels](/computer-engineering/100-go-mistakes/Not-using-nil-channels)
- [Being puzzled about channel size](/computer-engineering/100-go-mistakes/Being-puzzled-about-channel-size)
- [Forgetting about possible side effects with string formatting](/computer-engineering/100-go-mistakes/Forgetting-about-possible-side-effects-with-string-formatting)
- [Creating data races with append](/computer-engineering/100-go-mistakes/Creating-data-races-with-append)
- [Using mutexes inaccurately with slices and maps](/computer-engineering/100-go-mistakes/Using-mutexes-inaccurately-with-slice-and-maps)
- [Misusing sync.WaitGroup](/computer-engineering/100-go-mistakes/Misusing-sync-waitgroup)
- [Forgetting about sync.Cond](/computer-engineering/100-go-mistakes/Forgetting-about-sync-cond)
- [Not using errgroup](/computer-engineering/100-go-mistakes/Not-using-errgroup)
- [Copying a sync type](/computer-engineering/100-go-mistakes/Copying-a-sync-type)

## Standard library

- [Providing a wrong time duration](/computer-engineering/100-go-mistakes/Providing-a-wrong-time-duration)
- [time.After and memory leaks](/computer-engineering/100-go-mistakes/Time-after-and-memory-leaks)
- [Common JSON handling mistakes](/computer-engineering/100-go-mistakes/Common-JSON-handling-mistakes)
- [Common SQL mistakes](/computer-engineering/100-go-mistakes/Common-SQL-mistakes)
- [Not closing transient resources](/computer-engineering/100-go-mistakes/Not-closing-transient-resources)
- [Forgetting the return after replying to an HTTP request](/computer-engineering/100-go-mistakes/Forgetting-the-return-after-replying-to-an-http-request)
- [Using the default HTTP client and server](/computer-engineering/100-go-mistakes/Using-the-default-HTTP-client-and-server)

## Testing

- [Not categorizing tests](/computer-engineering/100-go-mistakes/Not-categorizing-tests)
- [Not enabling the -race flag](/computer-engineering/100-go-mistakes/Not-enabling-the-race-flag)
- [Not using test execution modes](/computer-engineering/100-go-mistakes/Not-using-test-execution-modes)
- [Not using table driven tests](/computer-engineering/100-go-mistakes/Not-using-table-driven-tests)
- [Sleeping in unit tests](/computer-engineering/100-go-mistakes/Sleeping-in-unit-tests)
- [Not dealing with the time API efficiently](/computer-engineering/100-go-mistakes/Not-dealing-with-the-time-API-efficiently)
- [Not using testing utility packages](/computer-engineering/100-go-mistakes/Not-using-testing-utility-packages)
- [Writing inaccurate benchmarks](/computer-engineering/100-go-mistakes/Writing-inaccurate-benchmarks)
- [Not exploring all the Go test features](/computer-engineering/100-go-mistakes/Not-exploring-all-the-Go-testing-features)

## Optimizations

- [Not understanding CPU caches](/computer-engineering/100-go-mistakes/Not-understanding-CPU-caches)
- [Writing concurrent code that leads to false sharing](/computer-engineering/100-go-mistakes/Writing-concurrent-code-that-leads-to-false-sharing)
- [Not taking into account instruction-level parallelism](/computer-engineering/100-go-mistakes/Not-taking-into-account-instruction-level-parallelism)
- [Not being aware of data alignment](/computer-engineering/100-go-mistakes/Not-being-aware-of-data-alignment)
- [Not understanding stack vs heap](/computer-engineering/100-go-mistakes/Not-understanding-stack-vs-heap)
- [Not knowing how to reduce allocations](/computer-engineering/100-go-mistakes/Not-knowing-how-to-reduce-allocations)
- [Not relying on inlining](/computer-engineering/100-go-mistakes/Not-relying-on-inlining)
- [Not using Go diagnostic tools](/computer-engineering/100-go-mistakes/Not-using-Go-diagnostic-tools)
- [Not understanding how the GC works](/computer-engineering/100-go-mistakes/Not-understanding-how-the-GC-works)
- [Not understanding the impacts of running Go in Docker and Kubernetes](/computer-engineering/100-go-mistakes/Not-understanding-the-impacts-of-running-Go-in-Docker-and-Kubernetes)

## References

- [100 Go Mistakes](/reference/100-Go-Mistakes-and-How-to-Avoid-Them)
