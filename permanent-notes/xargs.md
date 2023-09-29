type: #idea
subject: [Linux](Linux.md)
<!-- Subject should be a hub note -->
# xargs

The `xargs` command will run a command multiple times.

```bash
# Remove all .png files in the currect directory
find . -name "*.png" | xargs rm -rf
```

---
# References
<!-- What references back up this idea -->
[Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)