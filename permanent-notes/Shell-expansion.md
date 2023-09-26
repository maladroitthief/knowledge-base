type: #idea
subject: [Shell](Shell.md)
<!-- Subject should be a hub note -->
# Shell-expansion

Shell expansions are shortcuts that can save a significant amount of time typing.

## File globbing

Replacing a pattern in a file name or directory

| Expansion | Description |
| --------- | ----------- |
| ~ | Expansion for current home directory |
| * | Matches `0 TO n` characters |
| [ab] | Matches the characters `a OR b` |
| [0-9] | Matches characters in the sequence `0 TO 9` |
| [a-z] | Matches characters in the sequence `a TO z` |
| ^ | Negate the expansion: `^[ab]` is NOT a OR b |
| $ | Match the end: `a$` is ends in `a` |
| (PATTERN1\|PATTERN2) | Match `PATTERN1 OR PATTERN2` |

---
# References
<!-- What references back up this idea -->
[Command-Line-A-modern-introduction](Command-Line-A-modern-introduction.md)