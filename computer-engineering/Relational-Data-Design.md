---
title: Relational Data Design
layout: idea
tags:
  - data-oriented-design
---

# Relational Data Design

## Representing complex data in a computational framework

Data layout and structure is a constant trade-off between performance,
readability, maintenance, future-proofing, extendability, and reuse. While more
complex tables can achieve higher performance and readability, the cost becomes
future proofing, maintainability, and often scalability.

Moving towards a document store type of data storage is incredibly beneficial
for their simplicity and flexibility. They are more akin to file systems where
documents are accessed by name and have few limitations on how they are
structured. This is very good for horizontal scalability since it is easy to add
more hardware when data does not need to be consistent across multiple
tables/machines.

The relational model is a very good fit for developing non-sparse data layouts.
However, for widely scaled systems the relational model can be inappropriate.
Larger calculations and process now run via map-reduce. The most valuable high
level data processing techniques are often a combination of hardware-focused
data manipulation layers being used with functional type algorithms.

## Data Normalization

Relational models require atomicity when working with data. For our purposes,
this means normalizing data to the level of a noun, or a nameable piece.
Consider the following setup code:

```go
const mesh_room: Mesh = loadMesh("room_mesh");
const mesh_room_start: Mesh = loadMesh("room_start_mesh");
const mesh_room_trapped: Mesh = loadMesh("room_trapped_mesh");
const mesh_key: Mesh = loadMesh("key_mesh");
const mesh_potion: Mesh = loadMesh("potion_mesh");
const mesh_armor: Mesh = loadMesh("armor_mesh");

const texture_room: Texture = loadTexture("room_texture");
const texture_room_start: Texture = loadTexture("room_start_texture");
const texture_room_trapped: Texture = loadTexture("room_trapped_texture");
const texture_key: Texture = loadTexture("key_texture");
const texture_potion: Texture = loadTexture("potion_texture");
const texture_armor: Texture = loadTexture("armor_texture");

const animation_key_bob: Animation = loadAnimation("key_bob_animation");

const k1: PickupId = createPickup(
  type_key,
  mesh_key,
  texture_key,
  tint_color_copper,
);
const k2: PickupId = createPickup(
  type_key,
  mesh_key,
  texture_key,
  tint_color_silver,
);
const k3: PickupId = createPickup(
  type_key,
  mesh_key,
  texture_key,
  tint_color_gold,
);
const p1: PickupId = createPickup(
  type_potion,
  mesh_potion,
  texture_potion,
  tint_color_green,
);
const p2: PickupId = createPickup(
  type_potion,
  mesh_potion,
  texture_potion,
  tint_color_purple,
);
const a1: PickupId = createPickup(
  type_armor,
  mesh_armor,
  texture_armor,
  null,
);

const r1: Room = createRoom(
  worldPosition(0, 0),
  mesh_room_start,
  texture_room_start,
  null,
);
const r2: Room = createRoom(
  worldPosition(-20, 0),
  mesh_room_trapped,
  texture_room_trapped,
  hpDamage(10),
);
const r3: Room = createRoom(
  worldPosition(-10, 20),
  mesh_room,
  texture_room,
  null,
);
const r4: Room = createRoom(
  worldPosition(-30, 20),
  mesh_room,
  texture_room,
  null,
);
const r5: Room = createRoom(
  worldPosition(20, 10),
  mesh_room_trapped,
  texture_room_trapped,
  hpDamage(10),
);

addDoor(r1, r2, null);
addDoor(r1, r3, k1);
setRoomAsSpecial(r1, starting_room, worldPosition(1, 1));

addPickup(r2, k1, worldPosition(-18, 2));
addDoor(r2, r1, null);
addDoor(r2, r4, k2);

addPickup(r3, k2, worldPosition(-8, 12));
addPickup(r3, p1, worldPosition(-7, 13));
addPickup(r3, a1, worldPosition(-8, 14));
addDoor(r3, r1, null);
addDoor(r3, r2, null);
addDoor(r3, r5, k3);

addPickup(r4, k3, worldPosition(-28, 14));
addPickup(r4, p2, worldPosition(-27, 13));
addDoor(r4, r2);

setRoomAsSpecial(r5, exit_room, null);
```

This snippet is fairly complicated, involves multiple objects referencing each
other, and needs to orchestrated so that all pieces are created before they can
be referenced. This results in staggered phases of setup and linking. In order
to make this design more database-like, the data needs to be normalized into
tables.

**Meshes - 0NF**

| mesh_id           | mesh_name           |
| ----------------- | ------------------- |
| mesh_room         | "room_mesh"         |
| mesh_room_start   | "room_start_mesh"   |
| mesh_room_trapped | "room_trapped_mesh" |
| mesh_key          | "key_mesh"          |
| mesh_potion       | "potion_mesh"       |
| mesh_armor        | "armor_mesh"        |

**Textures - 0NF**

| texture_id           | texture_name           |
| -------------------- | ---------------------- |
| texture_room         | "room_texture"         |
| texture_room_start   | "room_start_texture"   |
| texture_room_trapped | "room_trapped_texture" |
| texture_key          | "key_texture"          |
| texture_potion       | "potion_texture"       |
| texture_armor        | "armor_texture"        |

**Animations - 0NF**

| animation_id      | animation_name      |
| ----------------- | ------------------- |
| animation_key_bob | "key_bob_animation" |

**Pickups - 0NF**

| pickup_id | mesh_id     | texture_id     | pickup_type | color_tint | animation         |
| --------- | ----------- | -------------- | ----------- | ---------- | ----------------- |
| k1        | mesh_key    | texture_key    | key         | copper     | animation_key_bob |
| k2        | mesh_key    | texture_key    | key         | silver     | animation_key_bob |
| k3        | mesh_key    | texture_key    | key         | gold       | animation_key_bob |
| p1        | mesh_potion | texture_potion | potion      | green      |                   |
| p2        | mesh_potion | texture_potion | potion      | purple     |                   |
| a1        | mesh_armor  | texture_armor  | armor       |            |                   |

**Rooms - 0NF**

| room_id | mesh_id           | texture_id           | world_position | pickups  | damage | doors_to | locked     | is_start   | is_end |
| ------- | ----------------- | -------------------- | -------------- | -------- | ------ | -------- | ---------- | ---------- | ------ |
| r1      | mesh_room_start   | texture_room_start   | 0, 0           |          |        | r2,r3    | r3 with k1 | true (1,1) | false  |
| r2      | mesh_room_trapped | texture_room_trapped | -20, 10        | k1       | 10hp   | r1,r4    | r4 with k2 | false      | false  |
| r3      | mesh_room         | texture_room         | -10, 20        | k2,p1,a1 |        | r1,r2,r5 | r5 with k3 | false      | false  |
| r4      | mesh_room         | texture_room         | -30, 20        | k3,p2    |        | r2       |            | false      | false  |
| r5      | mesh_room_trapped | texture_room_trapped | 20, 10         |          | 25hp   |          |            | false      | true   |

### Normalization

There are many stages of normalization, including six normal forms. It is
critical to know them and understand why they exist. Opting for a data first
approach instead of objects/classes allows for data to be manipulated together.
It also allows for changes to the design now require fewer changes to the data.

#### First Normal Form

Ever cell contains one and only one atomic value. There should exist no array of
values, no null entries, and every row should be distinct. All tables should
have a unique primary key to assist with sorting and optimizing data access. The
key should also be as small as possible and because of the uniqueness rule,
every row has an implicit key. This can include using the whole row as a key,
but this is to be avoided if possible.

On the topic of treating a row in a database as a key, think of the table as a
set and an insert is checking if a combination exists. This can be useful if the
number of possible values is small enough to be represented with a bit set. Bit
sets take up significantly less memory and can be accessing in $O(1)$ time.

To normalize to first normal form, we need to first remove null values and treat
them as new tables.

**Pickups - 1NF**

| pickup_id | mesh_id     | texture_id     | pickup_type |
| --------- | ----------- | -------------- | ----------- |
| k1        | mesh_key    | texture_key    | key         |
| k2        | mesh_key    | texture_key    | key         |
| k3        | mesh_key    | texture_key    | key         |
| p1        | mesh_potion | texture_potion | potion      |
| p2        | mesh_potion | texture_potion | potion      |
| a1        | mesh_armor  | texture_armor  | armor       |

**PickupTints - 1NF**

| pickup_id | color_tint |
| --------- | ---------- |
| k1        | copper     |
| k2        | silver     |
| k3        | gold       |
| p1        | green      |
| p2        | purple     |

**PickupAnimations - 1NF**

| pickup_id | animation         |
| --------- | ----------------- |
| k1        | animation_key_bob |
| k2        | animation_key_bob |
| k3        | animation_key_bob |

First normal form will create more tables with fewer columns in those tables and
will only create rows for things that matter. This means more memory usage, but
it also means that we no longer need to check for null values in our code,
removing unnecessary state.

**Rooms - 1NF**

| room_id | mesh_id           | texture_id           | world_position | is_start   | is_end |
| ------- | ----------------- | -------------------- | -------------- | ---------- | ------ |
| r1      | mesh_room_start   | texture_room_start   | 0, 0           | true (1,1) | false  |
| r2      | mesh_room_trapped | texture_room_trapped | -20, 10        | false      | false  |
| r3      | mesh_room         | texture_room         | -10, 20        | false      | false  |
| r4      | mesh_room         | texture_room         | -30, 20        | false      | false  |
| r5      | mesh_room_trapped | texture_room_trapped | 20, 10         | false      | true   |

**PickupInstances - 1NF**

| room_id | pickups |
| ------- | ------- |
| r2      | k1      |
| r3      | k2      |
| r3      | p1      |
| r3      | a1      |
| r4      | p2      |
| r4      | k3      |

**Doors - 1NF**

| room_id | doors_to |
| ------- | -------- |
| r1      | r2       |
| r1      | r3       |
| r2      | r1       |
| r2      | r4       |
| r3      | r1       |
| r3      | r2       |
| r3      | r5       |
| r4      | r2       |

**LockedDoors - 1NF**

| room_id | to_room | locked_with |
| ------- | ------- | ----------- |
| r1      | r3      | k1          |
| r2      | r4      | k2          |
| r3      | r5      | k3          |

**Traps - 1NF**

| room_id | damage |
| ------- | ------ |
| r2      | 10hp   |
| r5      | 25hp   |

Laying out data like this takes up less space in larger projects as the number
of null entries or arrays would have only increased with the increased
complexity. Now we can add new features without having to revisit the original
objects.

#### Second Normal Form

Second normal form is about trying to pull out columns that don't depend on only
a part of the primary key. This can happen when the table requires a compound
primary key. Consider the following alternative representation of pickups

**Pickups - 0NF**

| mesh_id     | texture_id     | pickup_type | color_tint |
| ----------- | -------------- | ----------- | ---------- |
| mesh_key    | texture_key    | key         | copper     |
| mesh_key    | texture_key    | key         | silver     |
| mesh_key    | texture_key    | key         | gold       |
| mesh_potion | texture_potion | potion      | green      |
| mesh_potion | texture_potion | potion      | purple     |
| mesh_armor  | texture_armor  | armor       |            |

**Pickups - 1NF**

| mesh_id     | texture_id     | pickup_type |
| ----------- | -------------- | ----------- |
| mesh_key    | texture_key    | key         |
| mesh_potion | texture_potion | potion      |
| mesh_armor  | texture_armor  | armor       |

**TintedPickups - 1NF**

| pickup_type | color_tint |
| ----------- | ---------- |
| key         | copper     |
| key         | silver     |
| key         | gold       |
| potion      | green      |
| potion      | purple     |

**Pickups - 2NF**

| pickup_id | pickup_type |
| --------- | ----------- |
| k1        | key         |
| k2        | key         |
| k3        | key         |
| p1        | potion      |
| p2        | potion      |
| a1        | armor       |

**PickupTints - 2NF**

| pickup_id | color_tint |
| --------- | ---------- |
| k1        | copper     |
| k2        | silver     |
| k3        | gold       |
| p1        | green      |
| p2        | purple     |

**PickupAssets - 2NF**

| mesh_id     | texture_id     | pickup_type |
| ----------- | -------------- | ----------- |
| mesh_key    | texture_key    | key         |
| mesh_potion | texture_potion | potion      |
| mesh_armor  | texture_armor  | armor       |

**PickupAnimations - 2NF**

| pickup_type | animation         |
| ----------- | ----------------- |
| key         | animation_key_bob |

#### Third Normal Form

Third Normal Form removes transitive dependencies on the primary key via another
column in the table. For example, any room that has a mesh will also have a
matching texture.

**Rooms - 1NF**

| room_id | mesh_id           | texture_id           | world_position | is_start   | is_end |
| ------- | ----------------- | -------------------- | -------------- | ---------- | ------ |
| r1      | mesh_room_start   | texture_room_start   | 0, 0           | true (1,1) | false  |
| r2      | mesh_room_trapped | texture_room_trapped | -20, 10        | false      | false  |
| r3      | mesh_room         | texture_room         | -10, 20        | false      | false  |
| r4      | mesh_room         | texture_room         | -30, 20        | false      | false  |
| r5      | mesh_room_trapped | texture_room_trapped | 20, 10         | false      | true   |

**Rooms - 3NF**

| room_id | texture_id           | world_position | is_start   | is_end |
| ------- | -------------------- | -------------- | ---------- | ------ |
| r1      | texture_room_start   | 0, 0           | true (1,1) | false  |
| r2      | texture_room_trapped | -20, 10        | false      | false  |
| r3      | texture_room         | -10, 20        | false      | false  |
| r4      | texture_room         | -30, 20        | false      | false  |
| r5      | texture_room_trapped | 20, 10         | false      | true   |

**TexturesAndMeshes - 3NF**

| texture_id             | mesh_name         | texture_name         |
| ---------------------- | ----------------- | -------------------- |
| texture_room_start     | room_start_mesh   | room_start_texture   |
| texture_room_trapped   | room_trapped_mesh | room_trapped_texture |
| texture_room           | room_mesh         | room_texture         |
| texture_texture_key    | key_mesh          | key_texture          |
| texture_texture_potion | potion_mesh       | potion_texture       |
| texture_texture_armor  | armor_mesh        | armor_texture        |

#### Boyce-Codd Normal Form

Boyce-Codd Normal Form, BCNF, is normalizing the functional dependencies.

**Rooms - BCNF**

| room_id | world_position | is_start | is_end |
| ------- | -------------- | -------- | ------ |
| r1      | 0, 0           | true     | false  |
| r2      | -20, 10        | false    | false  |
| r3      | -10, 20        | false    | false  |
| r4      | -30, 20        | false    | false  |
| r5      | 20, 10         | false    | true   |

**Rooms - BCNF**

| texture_id           | is_start | is_end |
| -------------------- | -------- | ------ |
| texture_room_start   | true     | false  |
| texture_room         | false    | false  |
| texture_room_trapped | false    | true   |

#### Domain Key Normal Form

Domain key normal form considered to be the last normal forms, but for
developing efficient data structures, it should be considered early and often.
Domain knowledge is preferable when writing code as it makes immediate sense.
Domain knowledge is the idea that data depends on other data, but only given
information about the domain in which it resides. It can also be presenting a
human interpretation of the data, but this is not always the case. Consider the
following transformation:

**TexturesAndMeshes - 3NF**

| texture_id             | mesh_name         | texture_name         |
| ---------------------- | ----------------- | -------------------- |
| texture_room_start     | room_start_mesh   | room_start_texture   |
| texture_room_trapped   | room_trapped_mesh | room_trapped_texture |
| texture_room           | room_mesh         | room_texture         |
| texture_texture_key    | key_mesh          | key_texture          |
| texture_texture_potion | potion_mesh       | potion_texture       |
| texture_texture_armor  | armor_mesh        | armor_texture        |

**Assets - DKNF**

| asset_id             | stubbed_name     |
| -------------------- | ---------------- |
| asset_room_start     | room_start\_\*   |
| asset_room_trapped   | room_trapped\_\* |
| asset_room           | room\_\*         |
| asset_texture_key    | key\_\*          |
| asset_texture_potion | potion\_\*       |
| asset_texture_armor  | armor\_\*        |

## Operations

Manipulating data will always be handled with either an insert, delete, or
update. It's considered best practice to only modify data using actions that
would be commonly found in a database to avoid unexpected state complexity. Even
though the data is now laid out like a database, we are not required to use a
query language to access it.

## Stream Processing

All data can be implemented as streams. Tables can be thought of as sets of all
possible permutations of the attributes. Processing a set can be thought of as
traversing the set and producing an output set. Given that sets are unordered,
this means we can trivially introduce parallel processing.

Stream processing, instead of random access processing, means that we can
process data without the need write to variables outside of the process. This
means no side-effects and easy parallelization because the order of operations
is irrelevant. This makes it easier to think about the system, inspect, debug,
extend, and interrupt it.

## References

- [Data-Oriented Design](/reference/Data-Oriented-Design)
