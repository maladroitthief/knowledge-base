---
tags:
  - idea
aliases:
---

# Service Level Indicators

A service level indicator (SLI) is a measurement of the level of service being provided. An SLI ranges from 0% - 100% where 0 means nothing works and 100 means nothing is broken. This consistency is useful for tooling and alerting.

## Design

When introducing SLIs, it can be useful to break them into two categories

### SLI specification

- A service outcome that you think matters

### SLI implementation

- SLI specification and how to measure it
- There could be many implementations for one specification

## Types of components

Another technique for getting started with SLIs is to break a system down into types of components. Here are some examples:

### Request driven

- User creates an event and expects a response

### Pipeline

- System periodically reads data from a database and writes to a distributed hash table for optimized searching
- System reads log files from many sources to generate reports

### Storage

- System accepts data and makes it available to be retrieved at a later date

## Examples

- Number of successful HTTP requests / total HTTP requests (success rate)
- Number of gRPC calls that completed successfully in < 100 ms / total gRPC requests
- Number of search results that used the entire corpus / total number of search results, including those that degraded gracefully
- Number of “stock check count” requests from product searches that used stock data fresher than 10 minutes / total number of stock check requests
- Number of “good user minutes” according to some extended list of criteria for that metric / total number of user minutes

## References

- [Site-Reliability-Engineering](Site-Reliability-Engineering.md)
