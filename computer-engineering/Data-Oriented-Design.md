---
title: Data Oriented Design
layout: hub
tags:
  - data-oriented-design
  - computer-engineering
---

# Data Oriented Design

Data-oriented design is an approach to software development that focuses on
separating the data from context and operations. It values leveraging
fundamental computer science data structures and algorithms rather than modeling
the problem domain in the application. The trade off is a sacrifice of human
readability and initial software development speed for flexibility, maintenance,
and performance.

Data oriented design is not a product or library to be added to a project, it is
a technique to be learned. While data can be generic in type it is rarely
generic in how it is used. Transformations can be generic, but the ordering and
selection of those transformations is literally the solution to the problem.

## Data is not the problem domain

The interpretation and context of the data should not be part of the data. The
real world problem domain should be defined instead using a sequence of
transformations and operations that are agnostic to the data. When classes take
ownership of data, they become difficult to re-use and the context becomes
fixed. It is easy to reason about how arrays, maps, and trees might interact and
transform one another. It is very difficult to reason about how a house, road,
commuter, and tree would interact and transform each other. Algorithms can often
be used and re-used on most primitives and data structures. Unique classes with
unique internal layouts and state make it difficult to use these algorithms if
not impossible to see how they would even apply. Data is simply facts that can
be interpreted in whatever way necessary to get the output data in the format it
needs to be. We only care about what transformations are applied and where that
data ends up.

### Questions

- What binds your data, is it a concept or implied meaning?
- Is you data layout defined by a single interpretation from a single point of
  view?
- How could your data be reinterpreted?
- What about your data makes it uniquely important?

## Data is the type, frequency, quantity, shape, and probability

While performance improvements are a consequence of data oriented design, they
should not be the focus. Data oriented design is about all aspects of the data.
The schema of the data is important, but the values and transformations are
equally if not more so. We assume that we know nothing about the true nature of
the problem and make the schema a second class citizen. Instead of planning for
all possible outcomes and making everything in our code adaptable, we plan for
the most probable input. That directs the choice of algorithm. Extend-ability,
complexity, and abstractions are discarded in favor of making transformations
and algorithms simple and replaceable.

### Questions

- What is the smallest unit of memory on your target platform?
- When reading data, what percentage of it actually gets used?
- How often is that data being used? Once or thousands of times?
- Is the data being accessed consistently, at randomly, or in bursts?
- Are you always modifying all of the data, part of the data, or is it just
  being read?
- Who does that data matter to and what about it do the care about?
- What are the latency and bandwidth constraints of your solution?
- What information do you have that isn't part of the data?

## Data can change

Data oriented design focuses on current solutions, not legacy or future proofing
for problems that don't exist yet. Future proof systems rarely are and they show
their weaknesses when real world designs change. Developing based on business
domain facts may making initial development easy and fast, but it can lay a
burden on maintenance and new feature development. Data oriented design handles
change with generic transformations that can be coupled and decoupled easier
than objects can be mutated. By keeping data and operations separate,
refactoring large changes is often a trivial or non-existent task, but it is
important to remember that the trade off is keeping track of what data is
necessary for each transformation.
