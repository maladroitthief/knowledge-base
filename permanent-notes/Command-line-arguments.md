---
tags:
  - idea
aliases:
---

# Command line arguments

Command line arguments are passed to command line applications and come in two varieties.

## Positional arguments

Positional arguments can be any number of arguments that are separated by a space. If an argument contains a space in it, it must either be escaped or surrounded with quotes

```bash
cd ~/workspace

# Escaping whitespace
cd ~/workspace/ian\ weller
cd "~/workspace/ian weller"

# This is technically two positional arguments being passed
echo Hello World
```

## Optional arguments

Arguments that are either prefixed with the short-form `-` or the long-form `--`. Optional arguments usually change the functionality of the command they are passed to. Short-form optional arguments can be separated out or combined.

```bash
ls -a -l
ls -al

# Optional arguments typically come before positional arguments
ls -al ~/workspace
```

Optional arguments additionally can be passed values.

## Multi-line

Longer strings of command line arguments can be split into multiple lines

```bash
ls \
-a \
-l
```

## References

- [Linux](Linux.md)
- [Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)
