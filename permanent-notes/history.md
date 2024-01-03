---
tags:
 - idea
aliases:
---

# history

History views the history of previously executed commands. Commands are kept in the $HISTFILE and are not updated until the user logs out. Updating the $HISTFILE can be forced using the command `history -w`.

## Reuse commands

Previously executed commands can be replayed using the `!` operator. This can work for both commands or specifying command parameters.

```bash
docker-compose -f ~/special-file.yml up -d

# replay the last command
!!

# replay specific command with last seen arguments
!docker-compose
```

## Hiding from history

Adding a space to the front of any command will prevent it from being written to the $HISTFILE.

```bash
# Adding a space hides this command
 docker-compose down
```

## References

- [Linux](Linux.md)
- [Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)
