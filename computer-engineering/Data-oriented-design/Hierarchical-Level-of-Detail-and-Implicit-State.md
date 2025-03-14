---
title: Hierarchical Level of Detail & Implicit State
layout: idea
tags:
  - data-oriented-design
---

# Hierarchical Level of Detail & Implicit State

##  Hierarchical Level of Detail

Hierarchical level of detail is when an object becomes more relevant it starts
to gain more detail or event starts to exist. Since entities can be implicit
based on their components and attributes, we can optimize their performance by
only loading data that is relevant. For example, if 100,000 objects are being
observed from a great distance away, it is optimal to only render those objects
at a resolution fitting for the view window. The level of detail heuristic can
be fine tuned so that the most relevant objects are always at the highest level
of detail, while other objects may be reduced to a lower level.

### Memento

When a high detail entity is reduced to a lower level of detail, it should store
some compressed instructions or data that have all the necessary instructions to
rebuild that entity, also known as a memento. If an entity becomes so irrelevant to
the user, the memento can be discarded. Mementos can also be manually discarded
in a way that is obvious to the user or even controlled by the user to improve
performance.

Mementos can also be generated just in time. It is possible to seed a generator
with details about the entity that needs to be created. This means that while we
are still generating a memento, we don't have to worry about having the overhead
of storing it, nor do we need to worry about the lifetime of the memento.

### Alternative Axes

Run-time variables are already used for controlling the state of the
application, but there is a passive response to what variables/axis is being
monitored. This is usually a graphical or logical level of detail, but this
could also be perception.
