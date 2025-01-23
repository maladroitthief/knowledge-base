---
title: Existential Processing
layout: idea
tags:
  - data-oriented-design
---

# Existential Processing

Existential processing attempts to provide a way to remove unnecessary querying
about whether or not to process data. For example, in most software it is common
to check for null and the verify objects are valid before processing. This
entire line of conditional checks can be removed if data could be trusted to be
in a valid state before being processed.

## Complexity

Cyclomatic complexity is a numeric representation of the complexity of programs,
specifically concerning flow control. In short, it is:

> 1 + number of conditionals

This number is very difficult to reason with when dealing with virtual function
calls because you need to know the number of possible methods that can fulfill
that request. This becomes impossible if you do not have access to all the code
that is running, such as with dynamic libraries. This hidden complexity is a
necessity for third party libraries to interface with core processes, but it
guarantees that no single part of the process will ever be thoroughly tested.

Another form of complexity is state. State is often concluded for being
responsible for the most complexity in all of software. State can be broken down
even further into accidental and essential state.

### Essential State

Essential state is state that is required by the problem being solved by the
program. This is any design or feature that is dependent on certain conditions
being met.

### Accidental State

Accidental state is state that is required for the software to run, but is not
required by the problem being solved. It is non-essential to the program, but
could be providing the foundation for the program.

#### Structural state

Structural state is accidental state necessary for supporting a programming
paradigm, offering performance improvements, or being used to drive an
algorithm.

#### Defensive programming

Defensive programming is accidental state is state meant to help the developer
like reference counting or garbage collection. Garbage collection adds and it is
rarely guaranteed how and when it will happen. As a result of ignoring memory
allocations during the early development stages in these languages, it can be
challenging to fix memory leaks closer to the ship date.

## Debugging

With high complexity programs it is common to run into a variety of issues.
Issues like a program being in an unexpected state or a bad state resulting in
unexpected behavior. High complexity of state can also introduce performance
related issues that become incredibly expensive. Caching, for example, is an
example of the complexity of state. The CPU cache can be in an unexpected state
resulting in poor or inconsistent performance.

## Conditional Flow Control

It is common practice to use conditionals to avoid crashes. Conditional checks
like out of bounds checks, access fail safes, null pointer protection, and many
other state validations to avoid failure.

Looping is another form of conditional flow control with the exception that the
compiler can often reason with loops and optimize them. Being able to reason
with looping, the compiler is able to discard any conditional checks that are
unnecessary.

Polymorphic calls are also a form of flow control. While they can provide aid,
they often provide abstractions for the sake of abstracting and introduce
complexity where it isn't needed.

To reduce complexity, we need to consider how we can eliminate as much flow
control as possible. Consider keeping data as a collection of arrays. This can
ensure that none of our data can be null and entirely eliminate one form of
defensive flow control. While this does not eliminate loops, we can better
reason with the data using functional transforms and avoid side-effects.

Virtual calls can be avoided entirely using either switch statements, function
pointers, or a long series of ifs.

Reducing the cyclomatic complexity is incredibly beneficial and should be
considered. It is important to reiterate that this is dependent on formatting
data in such a way that it does not allow for nulls. Using normalization
techniques we can instead of querying an object for it's relationships, we query
a structure that only contains the relationships between objects. This can be
incredibly potent in debugging.

Inefficient hardware utilization often comes from unpredictable processing. This
slowness comes from not being able to see how much work needs to be done and
being unable to prioritize or scale the work to fit the given time frame. Giving
the computer a known list of tasks to process enables the processor to optimize
and reduce overhead. When there are patterns of operation, preemptive streaming
or processing can be queued up when we know it will need done at some point in
the future. By allowing software to generate to-do lists and goals you can
simplify the work into prioritizing goals or write code to prioritize at
runtime.

## Types of Processing

Existential processing is related to to-do lists. When all elements of a list
are processed it can be concluded that they will be processed in the same exact
way. CPUs can efficiently handle running the same operation repeatedly over
contiguous data. When global state is removed, this now allows for
parallelization techniques like map-reduce. Stateless transforms of stateful
data are incredibly robust and trivial to run in parallel.

Inside of the processing of each element it is acceptable to use control flow.
Most compilers should be able to reduce these branching instructions to a
branch-free representation. SIMD, single instruction multiple data, allows
parallel processing of data when the instructions are the same. MIMD, multiple
instructions multiple data, every piece of data can be operated on by a
different set of instructions. This is simple, but prone to errors. Because it
is so simple, it is how most parallel processing is done and it often results in
rare fatal errors due to highly complex state.

### Filter

A filter takes incoming data with some constant parameters and produces either
one or zero outputs per every input.

### Mutation

A one to one manipulation of data. Incoming data and constant parameters are
processed and exactly one element is produced for every input.

### Emission

A one to many data manipulation. Using incoming data and constant parameters, an
emission can create zero, one, or many outputs for each input element.

### Generator

A generator takes no input data, but produces output elements based on the
constant parameters.

## Booleans

Instead of using booleans, consider the information that is encoded in data
using domain knowledge. Instead of adding a boolean to indicate state, consider
laying out the data to imply state. Having a row in a table to check for
existence is faster and less error prone than having to check a floating point
number or convert/cast a value to a boolean. Pointers can also introduce
unnecessary booleans with null value checks.

## Enums

Enums that influence instruction control flow can be emulated by replacing each
enum value with a table. This will make finding the enum value more challenging
as it will require checking all tables related to that enum. However, this
removes the internal state from the entity and places it in external tables and
reduce the impact of control flow. This approach should not be considered if the
enum is highly volatile and it would impact performance.

## Polymorphism

Instead of polymorphic class we can implement a factory of table insertions.
Instead of a polymorphic method we can leverage existential processing. The
table values should imply the characteristics of the entity.

### Dynamic run-time polymorphism

Run-time polymorphism is a class providing a different implementation of a base
operation where the class type is unknown at compile time. The class reacts
differently to function calls depending on it's type and the type can change at
run-time. Dynamic languages, like python, have few restrictions on class
definitions which can be very convenient at the high cost of performance.

Using existential processing, classes are defined by the tables they belong to.
Behavior then can be changed by just altering the table data rather than
managing state, data, or other run-time tricks.

Implicitly defined classes not only can be run-time polymorphic, they can also
belong to many tables at the same time. This added functionality allows the
implicit class to instead be multiple classes all at once.

## Event Handling

Having a table for event registration makes the subscribe and un-subscribe
operations very fast and very simple. Subscribe is an insert and un-subscribe is
a delete. This also enables subscribing to a topic before the publisher even
exists.
