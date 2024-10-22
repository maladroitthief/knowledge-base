---
tags:
  - idea
aliases:
---

# Shell script

<!--
	Write three to five sentences in your own words
	Assume that the reader will have no context
	Include sources
	Link to other ideas
-->

## Template

```bash
#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
    exit
fi

cd "$(dirname "$0")"

main() {
    echo do awesome stuff
}

main "$@"
```

## References

- [Shell](permanent-notes/Shell.md)
