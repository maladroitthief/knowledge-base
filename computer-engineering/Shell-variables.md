---
title: Shell variables
layout: idea
tags:
  - linux
---

# Shell-variables

Shell variables are variables that are only applied to the current shell
instance.

```bash
var=TestVar
echo $var
echo ${var} # long format for expressions in strings
```

## Environment variables

Environment variables are shell variables that are inherited by all system
processes. A shell variable can be promoted to an environment variable by
exporting it.

```bash
export var=TestVar
```

All current environment variables can be viewed using `export`

## References

- [Command-Line-A-modern-introduction](/reference/Command-Line-A-modern-introduction)
