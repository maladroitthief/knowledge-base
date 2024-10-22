---
title: xargs
layout: idea
tags:
  - linux
---

# xargs

The `xargs` command will run a command multiple times.

```bash
# Remove all .png files in the currect directory
find . -name "*.png" | xargs rm -rf
```

## References

- [Command-Line-A-modern-introduction](/reference/Command-Line-A-modern-introduction)
