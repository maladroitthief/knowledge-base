---
tags:
 - idea
aliases:
---

# Anonymous-Functions

An anonymous function is a function with no name, usually defined inside the scope of another function.

Anonymous functions are considered **first class citizens**. The can be passed as **parameters**, **returned** by other functions, or bound to **variables**. Anonymous functions can also be used in **type declarations** which makes them useful as function wrappers.

```go
// as a Type declaration
type Wrapper func(string)
// as a parameter
func paramFunc(f func()){
	f()
}
// as a return
func returnFunc() func() {
	return func(){
		fmt.Println("return")
	}
}
// as a variable
func main(){
	f := func(){
		fmt.Println("variable")
	}
}
```

Anonymous functions defined inside of another function it captures the lexical context of the surrounding function.

```go
func counter() func() {
	k := 1
	return func() {
		fmt.Printf("Count %v\n", k)
		k++
	}
}
```

## References

- [Software-Engineering](Software-Engineering.md)