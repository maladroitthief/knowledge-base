---
title: Component Based Objects
layout: idea
tags:
  - data-oriented-design
---

# Component Based Objects

Thinking using components instead of inheritance can prevent needlessly linking
ideas that are unrelated to one another. Objects built this was can be then
processed by component type, rather than object instance, making it easier to
profile. Using components typically can make extending functionality easier
since they often don't need to modify existing components, they either extend it
or provide alternatives.

## Compound Objects

A compound object is base entity instance that has a list of components. The
core object merely holds the components and they communicate to each other
through it. The entity usually will update by iterating over root instances
rather than systems. This is a great start, but is not a fully component based
approach. The entity is more readable, reusable, and robust allowing it to
support a larger system and be reusable between projects.

### Original Implementation

```go
type Player struct {
  Pos                Vec
  Up                 Vec
  Forward            Vec
  Right              Vec
  Velocity           Vec
  Health             float64
  XP                 int
  UsedPowerups       int
  ShotsPerSecond     float64
  TimeSinceLastShot  float64
  IdleAnim           AnimID
  ShootAnim          AnimID
  ReloadAnim         AnimID
  MovementAnim       AnimID
  CurrentAnimGoal    AnimID
  CurrentAnim        AnimID
}
```

### Compound Object

```go
type Player struct {
  Physical  PlayerPhysical
  Gameplay  PlayerGameplay
  Animation EntityAnimation
}

type PlayerPhysical struct {
  Pos      Vec
  Up       Vec
  Forward  Vec
  Right    Vec
  Velocity Vec
}

type PlayerGameplay struct {
  Health          float64
  XP              int
  UsedPowerups    int
  ShotsPerSecond  float64
  TimeSinceLastShot float64
}

type EntityAnim struct {
  IdleAnim           AnimID
  ShootAnim          AnimID
  ReloadAnim         AnimID
  MovementAnim       AnimID
  CurrentAnimGoal    AnimID
  CurrentAnim        AnimID
}
```

## Component oriented design

A truly component based object is nothing more than the sum of it's parts. The
object is not rigidly defined, but instead have it's characteristics described
through components. Classes become containers of smaller objects. Instead of the
"is-a" relationship of Object Oriented Design, Component Oriented Design is a
"has-a" approach.

When deciding on how to draw the boundaries of components, consider the needs of
each piece as well as their requirements. This is not always easy and will take
some consideration.

### Component Managers

To allow for a clean separation, have components be managed by managers rather
than the entity. This promotes cache locality when we iterate over multiple
entities/components that are doing similar tasks.

```go
type RenderManager struct {
  RenderArray []Renderable
}

func (rm *RenderManager) Update(gRenderer *Renderer, posArray []Vec) {
  gRenderer.BeginFrame()
  for _, renderable := range rm.RenderArray {
    renderable.RenderUpdate(gRenderer, posArray)
  }
  gRenderer.SubmitFrame()
}

///////////////////////////////////////////////////////////////////////////////

type PhysicsRequest struct {
  Index      int
  UpdateData interface{} // Placeholder for physics update data
}

type PhysicsManager struct {
  PhysicsRequestArray []PhysicsRequest
  PhysicalArray       []Physical
  PositionArray       []Vec
}

func (pm *PhysicsManager) Update() {
  for _, physicsRequest := range pm.PhysicsRequestArray {
    pm.PhysicalArray[physicsRequest.Index].UpdateValues(physicsRequest.UpdateData)
  }

  // Run physics simulation
  for i := range pm.PhysicalArray {
    pm.PositionArray[i].Pos = pm.PhysicalArray[i].Pos
  }
}
```

Systems have specific needs in order to function properly. In some cases the
needs of these systems will overlap, but they will not share all data between
them. Using an object oriented approach, a lot of irrelevant data ends up being
shared between systems. This noise is also taking up precious space in the CPU
cache and is making an impact on performance.

Class functionality is the interpretation of internal state over time.
Interpreting the relationship of state or data is part of the problem, but in
the end it's just data. We aim to separate data from meaning which is difficult
if not impossible when all the data is in one place. By isolating data we remove
the need to have classes that inscribe permanent meaning at the cost of having
to query the data in indirect ways.

Instead of classes accessing data in their components, transforms on the class
should be how we access variables. Rather than a single `update()` call on the
entity, we have an `update()` for every component that the entity is comprised
of. These component transformations being handled by managers is beginning to
open us up to parallel processing techniques and allows us to optimize how
frequently these transforms need to be run.

The final stage of component oriented programming is removing the entity
all-together. Removing compile time classes and instead having entities implied
by their component definitions increases the power of composition tremendously.

```go
// Assuming some container like SparseArray exists
var (
  orientationArray SparseArray[Orientation] = make(SparseArray[Orientation])
  velocityArray    SparseArray[Vec]         = make(SparseArray[Vec])
  healthArray      SparseArray[float64]     = make(SparseArray[float64])
  xpArray          SparseArray[int]         = make(SparseArray[int])
  controllerID     SparseArray[int]         = make(SparseArray[int])
  inventoryArray   SparseArray[[]ItemType]  = make(SparseArray[[]ItemType])
)

func NewPlayer(gamepadID int, startPoint Vec) int {
  ID := NewID()

  controllerID[ID] = padID
  GetAsset("PlayerModel", ID) // Adds a request to put the player model into modelArray[ID]
  velocityArray[ID] = VecZero()
  orientationArray[ID] = Orientation{Pos: startPoint}

  return ID
}
```
