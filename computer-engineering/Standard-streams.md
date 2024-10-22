---
title: Standard streams
layout: idea
tags:
  - linux
---

# Standard-streams

Standard in, out, and error streams created when a command is run. They are
usefully for passing data between applications. Most CLI applications support
using `stdin` as in input and will create both `stdout` and `stderr` outputs,
allowing multiple commands to be chained together.

The streams behave like files and are given the following descriptors:

- `stdin`: 0
- `stdout`: 1
- `stderr`: 2

These streams can be redirected using `>` or `>>` where `>` overwrites the file
and `>>` appends to the end. To redirect a specific stream, prepend the
operators with the stream descriptor.

```bash
# redirect stderr to error.log
python script.py 2> error.log
# redirect stdout and stderr
python script.py 1> output.txt 2> error.log
python script.py &> script.log
# discard streams
python script.py &> /dev/null
```

Streams can also be piped to the stdin of another command.

```bash
echo "Hello" | sed "s/Hello/World/"
```

Standard input can also be redirected.

```bash
cat << END
line one
line two
END
```

## References

- [Command-Line-A-modern-introduction](/reference/Command-Line-A-modern-introduction)
