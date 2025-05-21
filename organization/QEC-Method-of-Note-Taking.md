---
title: QEC Method
layout: idea
tags:
  - idea
---

# QEC Method of Note Taking

QEC note taking is a method described by [Cal Newport][1] in the book
[student][2] which stands for **question**, **evidence**, and **conclusion**. It
aims to make notes easy to review, identify how much evidence actually supports
a claim, and make note taking fast either handwritten or typed.

## [Steps][3]

1. **Question:** List questions from the text or your own questions about the
   material
2. **Evidence:** Read to find evidence that answers the question
3. **Conclusion:** Summarize the evidence into a statement

## Example

### [Original Text][4]

> Catalog
>
> You may think of Iceberg as a format for managing data in a single table, but
> the Iceberg library needs a way to keep track of those tables by name. Tasks
> like creating, dropping, and renaming tables are the responsibility of a
> catalog. Catalogs manage a collection of tables that are usually grouped into
> namespaces. The most important responsibility of a catalog is tracking a
> table's current metadata, which is provided by the catalog when you load a
> table.
>
> The first step when using an Iceberg client is almost always initializing and
> configuring a catalog. The configured catalog is then used by compute engines
> to execute catalog operations. Multiple types of compute engines using a
> shared Iceberg catalog allows them to share a common data layer.
>
> A catalog is almost always configured through the processing engine which
> passes along a set of properties during initialization. Different processing
> engines have different ways to configure a catalog. When configuring a
> catalog, it’s always best to refer to the Iceberg documentation as well as the
> docs for the specific processing engine being used. Ultimately, these
> configurations boil down to a common set of catalog properties that will be
> passed to configure the Iceberg catalog.

### QEC Notes

- What is a Catalog?
  - a way to track tables by name
  - is responsible for creating, dropping, and renaming tables
  - manages a collection of tables that can be grouped into namespaces
  - tracks a table's current metadata
    - provided to the catalog on loading the table
  - first step using an Iceberg client is initializing a catalog
  - used by compute engines to execute catalog operations
  - multiple types of compute engines can share an Iceberg catalog
    - allows them to share a common data layer
  - **A catalog is a client side abstraction for managing Iceberg Tables**

[1]: https://calnewport.com/

<!-- prettier-ignore -->
[2]: https://www.goodreads.com/book/show/253203.How_to_Become_a_Straight_A_Student
[3]: https://www.utsc.utoronto.ca/learningstrategies/qec-method
[4]: https://iceberg.apache.org/terms/#catalog
