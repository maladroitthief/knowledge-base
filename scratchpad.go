package main

import "os"

func main() {
}

func readFiles(ch <-chan string) error {
	for path := range ch {
		file, err := os.Open(path)

		if err != nil {
			return err
		}

		// This is deferred when readFiles exits, not the current iteration
		defer file.Close()
	}

	return nil
}
