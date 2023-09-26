type: #idea
subject: [Linux](Linux.md)

<!-- Subject should be a hub note -->

# Standard-streams

Standard in, out, and error streams created when a command is run. They are usefully for passing data between applications.
Most CLI applications support using `stdin` as in input and will create both `stdout` and `stderr` outputs, allowing multiple commands to be chained together.

The streams behave like files and are given the following descriptors:

- `stdin`: 0
- `stdout`: 1
- `stderr`: 2

These streams can be redirected using `>` or `>>` where `>` overwrites the file and `>>` appends to the end.
To redirect a specific stream, prepend the operators with the stream descriptor.

```bash
# redirect stderr to error.log
python script.py 2> error.log
```

---

# References

<!-- What references back up this idea -->

[Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)
