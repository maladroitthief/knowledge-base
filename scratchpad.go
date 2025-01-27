package main

import "strings"

func main() {
}

func concat(values []string) string {
	total := 0
	// Get total number of bytes
	for i := 0; i < len(values); i++ {
		total += len(values[i])
	}

	sb := strings.Builder{}
	sb.Grow(total)
	for _, value := range values {
		_, _ = sb.WriteString(value)
	}

	return sb.String()
}
