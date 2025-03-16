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
responsible for most of the complexity in all of software. State can be broken
down even further into accidental and essential state.

### Essential State

Essential state is state that is required by the problem being solved by the
program. This is any design or feature that is dependent on certain conditions
being met. Essential state often cannot be avoided and is the entire point of
the problem being solved.

```go
if !authorized(token) {
  return
}
```

### Accidental State

Accidental state is state that is required for the software to run, but is not
required by the problem being solved. It is non-essential, but could be
providing the foundation for the application.

#### Structural state

Structural state is accidental state necessary for supporting a programming
paradigm, offering performance improvements, or being used to drive an
algorithm. This is state that can be avoided while still solving the problem at
hand.

```go
if !memory.isInitialized {
  // ...
  memory.isInitialized = true
}

```

#### Defensive programming

Defensive programming is accidental state is state meant to help the developer
like reference counting or garbage collection. Garbage collection adds
complexity and it's rarely guaranteed how and when the collector will run. As a
result of ignoring memory allocations during the early development stages in
garbage collected languages, it can be challenging to fix memory leaks during
later stages of development.

```go
if msg == "" {
  return
}

if value <= 0 {
  return
}
```

### Debugging

With high complexity programs it is common to run into a variety of issues. A
program could be in an unexpected or bad state resulting in unpredictable
behavior. The high complexity of state can also introduce performance related
issues that become incredibly expensive. CPU caching is also considered to be an
example of complex state. The CPU cache can be in an unexpected state resulting
in poor or inconsistent performance.

### Conditional Flow Control

It is common practice to use conditionals to avoid crashes. Conditional checks
like out of bounds checks, access fail safes, null pointer protection, and many
other state validations to avoid failure. This is more accidental state and more
complexity.

```go
func processEntity(entity *Entity) {
  if entity.State == nil {
    return
  }

  if entity.State == Active {
    updateActive(entity)
  } else if entity.State == Idle {
    updateIdle(entity)
  } else if entity.State == Destroyed {
    destroyEntity(entity)
  }
}
```

#### Reducing flow control

Looping is another form of conditional flow control with the exception that the
compiler can often reason with loops and optimize them. Because of this, the
compiler is able to discard any conditional checks that are unnecessary.

To reduce complexity, we should consider how we can eliminate as much flow
control as possible like storing data as a collection of arrays. This can ensure
that none of our data can be null and entirely eliminate one form of defensive
flow control. While this does not eliminate loops, we can better reason with the
data using functional transforms to avoid side-effects.

```go
func processEntities(activeEntities []Entity, idleEntities []Entity, destroyedEntities []Entity) {
  for _, entity := range activeEntities {
    updateActive(entity)
  }

  for _, entity := range idleEntities {
    updateIdle(entity)
  }

  for _, entity := range destroyedEntities {
    destroyEntity(entity)
  }
}
```

#### Inessential flow control

Polymorphic calls are also a form of flow control. While they can provide aid,
they often provide abstractions for the sake of abstracting and introduce
complexity where it isn't needed.

```go
// EntityProcessor defines the interface for processing entities
type EntityProcessor interface {
  GetID() int
  Process()
}

type Player struct {
  ID    int
  Health int
  Score  int
}

func (p *Player) GetID() int {
  return p.ID
}

func (p *Player) Process() {
  fmt.Printf("Processing Player %d: Health=%d, Score=%d\n", p.ID, p.Health, p.Score)
  p.Score += 10
}

///////////////////////////////////////////////////////////////////////////////

for _, entity := range entities {
  entity.Process()
}
```

Virtual calls can be avoided entirely using either switch statements, function
pointers, or a long series of ifs.

```go
// Entity represents the common structure for all entities
type Entity struct {
  ID   int
  Type string // Probably should consider an enum here
}

// PlayerData holds player-specific data
type PlayerData struct {
  Health int
  Score  int
}

///////////////////////////////////////////////////////////////////////////////

for _, entity := range gameState.Entities {
  switch entity.Type {
  case "player":
    processPlayer(&gameState, entity.ID)
  case "enemy":
    processEnemy(&gameState, entity.ID)
  case "item":
    processItem(&gameState, entity.ID)
  default:
    fmt.Printf("Unknown entity type: %s\n", entity.Type)
  }
}
```

### Benefits

Reducing the cyclomatic complexity is incredibly beneficial and should be
considered. Using normalization techniques we can avoid querying an object for
it's relationships and instead query a structure that only contains the
relationships between objects. This can be incredibly potent in debugging.

Inefficient hardware utilization often comes from unpredictable processing. This
slowness comes from not being able to see how much work needs to be done and
being unable to prioritize or scale the work to fit the given time frame. Giving
the CPU a list of tasks with a known length to process enables the processor to
optimize and reduce overhead.

When there are operational patterns that emerge, preemptive streaming or
processing can be queued up in advance knowing that it will need to be processed
at some point in the future. By allowing software to generate to-do lists and
goals we can simplify the work into prioritizing tasks and write code to
prioritize tasks at run-time.

## Types of Processing

When processing all elements of a list we can make the conclusion that each item
will be processed identically. CPUs are very efficient at running the same
operation repeatedly over contiguous data. When global state is removed, this
now opens up our application to parallel processing techniques like map-reduce.
Stateless transforms of stateful data are incredibly robust and trivial to run
in parallel.

Inside of the transform it is perfectly acceptable to use control flow. Most
compilers should be able to reduce these branching instructions to a branch-free
representation, but it would be best to observe stream processing best
practices.

SIMD, single instruction multiple data, allows parallel processing of data when
the instructions are the same. The same operation can be applied to several
items at the same time.

MIMD, multiple instructions multiple data, every piece of data can be operated
on by a different set of instructions. This is simple, but prone to errors.
Because it is so simple, it is how most parallel processing is done and it often
results in rare fatal errors due to highly complex state.

### Filter

A filter takes incoming data with some constant parameters and produces either
one or zero outputs per every input.

```go
func filter[T comparable](inputs []T, f func(T) bool) []T {
  output := make(T, 0, len(inputs))

  for _, input := range inputs {
    if f(input) {
      output = append(output, input)
    }
  }

  return output
}
```

### Mutation

A one to one manipulation of data. Incoming data and constant parameters are
processed and exactly one element is produced for every input.

```go
func filter[T any](inputs []T, f func(T) T) []T {
  output := make(T, len(inputs))

  for i := 0; i < len(inputs); i++ {
    output[i] = f(inputs[i])
  }

  return output
}
```

### Emission

A one to many data manipulation. Using incoming data and constant parameters, an
emission can create zero, one, or many outputs for each input element.

```go
func emission[T any](inputs []T, f func(T) []T) []T {
  output := make(T, len(inputs))

  for i := 0; i < len(inputs); i++ {
    output = append(output, f(inputs[i])...)
  }

  return output
}
```

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

### Explicit state

```go
type User struct {
  Active bool
}

var users := []User{}

for _, user := range users {
  if user.Active {
    user.Update()
  }
}
```

### Implicit state

```go
type User struct {
}

var activeUsers := []User{}

for _, user := range activeUsers {
  user.Update()
}
```

## Enums

Enums that influence instruction control flow can be emulated by replacing each
enum value with a table. This will make finding the enum value more challenging
as it will require checking all tables related to that enum. However, this
removes the internal state from the entity and places it in external tables and
reduce the impact of control flow. This approach should not be considered if the
enum is highly volatile and it would impact performance.

### Enum representation

```go
type HealthState int

const (
	InFullHealth HealthState = iota
	IsHurt
	IsDead
)
```

### Table representation

```go
type Entity struct {
	ID   int
	Name string
}

var inFullHealthEntities []Entity{}
var isHurtEntities []Entity{}
var isDeadEntities []Entity{}

func moveToHurt(entity Entity) {
  inFullHealthEntities = slices.DeleteFunc(inFullHealthEntities, func(x Entity) bool {
    return x.ID == entity.ID
  })
	isHurtEntities = append(isHurtEntities, entity)
}
```

## Polymorphism

Instead of polymorphic class we can implement a factory of table insertions.
Instead of a polymorphic method we can leverage existential processing. The
table values should imply the characteristics of the entity.

### Dynamic run-time polymorphism

Run-time polymorphism is providing a different implementation of a base class
operation where the class type is unknown at compile time. The class reacts
differently to function calls depending on it's type and the type can vary at
run-time. Dynamic languages, like python, have few restrictions on class
definitions which can be very convenient at the cost of performance.

Using existential processing, classes are defined by the tables they belong to.
Behavior then can be changed by altering the table data instead of managing
state, data, or other run-time tricks.

Implicitly defined classes not only can be run-time polymorphic, they can also
belong to many tables at the same time. This added functionality allows the
implicit class to instead be multiple classes all at once.

#### Object oriented approach

```go
type Shape interface {
  Area() float64
}

type Circle struct {
  Diameter float64
}

func (c *Circle) Area() float64 {
  return c.Diameter * c.Diameter * math.Pi / 4
}

type Square struct {
  Width float64
}

func (s *Square) Area() float64 {
  return s.Width * s.Width
}
```

#### Dynamic run-time polymorphism

```go
type ShapeType int

const (
  CircleType ShapeType = iota
  SquareType
)

type MutableShape struct {
  Type           ShapeType
  DistanceAcross float64
}

func (m *MutableShape) Area() float64 {
  switch m.Type {
  case CircleType:
    return m.DistanceAcross * m.DistanceAcross * math.Pi / 4
  case SquareType:
    return m.DistanceAcross * m.DistanceAcross
  default:
    return 0
  }
}

func (m *MutableShape) SetNewType(shapeType ShapeType) {
  m.Type = shapeType
}
```

## Event Handling

Having a table for event registration makes the subscribe and un-subscribe
operations very fast and very simple. Subscribe is an insert and un-subscribe is
a delete. This also enables subscribing to a topic before the publisher even
exists.
