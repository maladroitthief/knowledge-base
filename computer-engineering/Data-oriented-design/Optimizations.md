---
title: Optimizations
layout: idea
tags:
  - data-oriented-design
---

# Optimizations

Optimizations cannot be done blindly, you need to know what is causing the code
to run slowly. In most cases, data movement tends to be the most expensive
operation while running algorithms or functions on data is less expensive. If
you begin development by organizing your data into arrays, you open yourself up
to many opportunities for optimization. By having such an agnostic data layout,
any improvements made can be applied in many locations with little concern for
incompatibility.

To go even further, by using stateless transformations we can also be assured
that we are not introducing unexpected side effects. Most projects suffer from
not thinking about optimization early enough, claiming that premature
optimization is inherently bad. However, optimization late in project's life
cycle becomes nearly impossible with object instances existing everywhere and
flawed design patterns heavily entrenched into the code.

A primary flaw with Object Oriented Design is the idea that an Object Instance
is an atomic unit of processing. This assumption leads to collections of objects
should be treated as collections of individuals. This concept is true, but it
then directs all instructions to flow through those object instances. This works
at small scale, but when considering hundreds of individual objects that now
need to be processed sequentially, the wheels fall off. Objects tend to exist
just to mirror how things exist in the real world. This leads to features being
added that match some real world relationship. This is engineering by
story-telling and is unreasonable.

## When should we optimize?

Premature optimization is proposing a solution without knowing whether it will
actually make a difference. Optimizing without using any data to prove that the
code is slow or is using too much memory is bad and premature. Without
profiling, even if the code is visually running slow and erratic, any changes
introduced are by definition premature optimizations.

The only way to avoid premature optimization is to look at data. Profile the
application and observe the results. Any improvements after this cannot be
premature, because they have been measured. Theses measurements can then be
evaluated in terms of failure, success, or progress.

Profiling should only start when you have metrics to work towards. When metrics
have been defined we can begin profiling. Without having any metrics defining
what is considered to be optimal, it is unreasonable to check the performance of
the code.

## Feedback

Not being aware that you are writing poorly optimized code hurts more than just
the application. Having zero feedback, people cannot improve their skills. This
leads to enforcing bad habits and producing even more bad results. Delayed
feedback isn't great either because it limits the opportunity to internalize the
feedback and develop intuition.

Adding performance metrics for the code that can be quickly observed helps with
this process. Learning early that a technique is slow helps remove the sunk cost
fallacy that can develop over time. Additionally, having data that proves an
approach is bad/slow is capable of winning over the most stubborn engineers.
Curiosity is a powerful remedy for the developer with a wounded ego.

A classic method of developing software is allocating budgets for time, memory,
bandwidth, disk, and any other limitations that could impact performance. Any
sort of limitation that can impact the application should have a budget.
Establishing budgets early and complying with them will eliminate future grief
in the product life cycle. This prevents early poor design decisions from
getting deeply integrated.

Get or build a profiler that runs constantly, providing detailed breakdowns
whenever any budget is exceeded.

## Strategy

### Define

- Find out what is believed to be bad
- Define the problem in factual terms and then define a solution/goal
  - Example: "The route takes 500 ms and it needs to be under 200 ms"
- Do not guess (engineer by story-telling) what the optimizations should be
- Consider writing from the user's perspective instead of a developer

### Measure

- Measure the problem and verify it exists
- Discern the quality of your measurements
- Run tests and re-run them to ensure the problem is reproducible

### Analyze

- Analyze the measurements
  - If the measurements did not provide enough direction, fix that above all
    else
  - Optimizations cannot be made without understanding their cost
- Make predictions about the impact of the optimization
  - Take this seriously, you cannot honestly guess after a solution is
    implemented
  - Building intuition about the impact of change is an incredibly valuable
    skill

### Implement

- Make the changes to fix the problem
- Do local prototype first and prove the changes to be useful
  - This can be faster than fully implementing a change in a legacy codebase

### Confirm

- Create a report of what was done and what was found
- This is not optional, this is the best method for retaining knowledge that was
  learned while making the optimizations
- This report can now be shared to help others struggling with the same issue
- It can also identify errors of measurement or steps taken that were not
  pertinent to the actual change that was made
- Reports can be criticized by colleagues who can point out illogical leaps of
  reasoning, false assumptions, and will lead to an overall better understanding
  of the system being optimized
- Being able to report and communicate your thoughts and process to colleagues
  is a foundational building block for all engineers

### Summary

- Keep track of what you are doing
- Make sure all work is reproducible
- Take notes on all steps in the process in case you need to revisit earlier
  changes or have to step away
- If you cannot measure the problem with the tools you have, find more tools
- If you cannot find the tools to measure the problem, make them
- Do not surrender yourself to wishful thinking or hopeful optimizations
  - This leads to bad habits, poor intuition, and false facts being learned by
    random chance

## Tables

Keeping data as vectors has a lot of positive benefits. Whether this is a
standard implementation or a roll-your-own dynamic array, it's a great starting
point for future improvements. Most processing will end up being reading an
array, transforming one array to another, or modifying it in place.

One step further is moving from an array to a structure of arrays, but only if
the access patterns fit. When considering how to structure data, it is important
to consider how it will be loaded and stored. CPUs are optimized for certain
patterns of memory activity. Often there can be a cost when switching from read
to write operations and it can be beneficial to arrange writing to memory to be
predictable and serial.

The following code example contains a mixture of hot/cold writes:

```go
type PosInfo struct {
  Pos      Vec3
  Velocity Vec3
}

type Nodes struct {
  PosInfos []PosInfo
}

func updateNodes(nodes *Nodes, trialCount int, nodeCount int, deltaTime float32) {
  for times := 0; times < trialCount; times++ {
    posInfos := nodes.PosInfos

    for i := 0; i < nodeCount; i++ {
      posInfos[i].Pos.X += posInfos[i].Velocity.X * deltaTime
      posInfos[i].Pos.Y += posInfos[i].Velocity.Y * deltaTime
      posInfos[i].Pos.Z += posInfos[i].Velocity.Z * deltaTime
    }
  }
}
```

We can modify the data layout to avoid loading data that is not being written:

```go
type Nodes struct {
  Positions  []Positions
  Velocities []Velocities
}

func updateNodes(nodes *Nodes, trialCount int, nodeCount int, deltaTime float32) {
  for times := 0; times < trialCount; times++ {
    for i := 0; i < nodeCount; i++ {
      nodes.Positions[i].X += nodes.Velocities[i].X * deltaTime
      nodes.Positions[i].Y += nodes.Velocities[i].Y * deltaTime
      nodes.Positions[i].Z += nodes.Velocities[i].Z * deltaTime
    }
  }
}
```

The struct of arrays can be more CPU cache friendly, but only if the data is not
strongly related for reading and writing. It would make little sense in this
case to isolate the X, Y, and Z values into their own arrays since they are
handled as a unit.

Another argument against struct of arrays as a solution is for data that is
frequently inserted and deleted. This can be mitigated by using a "free list" to
prevent the array from being mutated, but this adds more complexity and can be
not worth the effort.

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
