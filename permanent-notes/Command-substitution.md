type: #idea
subject: [Linux](Linux.md)
<!-- Subject should be a hub note -->
# Command-substitution

Command substitution replaces itself with the internal command.

```bash
python script.py --secret_key "$(cat ~/.secret_key)"
```

Alternatively, process substitution can be used to instead create a temporary file with the contents of the command, and then return the file path.

```bash
python script.py --file <(python generate_key.py)
```

---
# References
<!-- What references back up this idea -->
[Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)