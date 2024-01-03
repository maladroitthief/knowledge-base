---
tags:
 - idea
aliases:
---

# Command-substitution

Command substitution replaces itself with the internal command.

```bash
python script.py --secret_key "$(cat ~/.secret_key)"
```

Alternatively, process substitution can be used to instead create a temporary file with the contents of the command, and then return the file path.

```bash
python script.py --file <(python generate_key.py)
```

## References

- [Linux](Linux.md)
- [Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)
