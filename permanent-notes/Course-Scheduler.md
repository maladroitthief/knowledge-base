type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Course-Scheduler

There are a total of `numCourses` courses you have to take, labeled from `0` to `numCourses - 1`. You are given an array `prerequisites` where `prerequisites[i] = [ai, bi]` indicates that you **must** take course `bi` first if you want to take course `ai`.

- For example, the pair `[0, 1]`, indicates that to take course `0` you have to first take course `1`.

Return `true` if you can finish all courses. Otherwise, return `false`.

## Method

DFS with a visited list. Any cycle is considered a failure

## Solution

### go

```go
func canFinish(numCourses int, prerequisites [][]int) bool {
	pMap := map[int][]int{}
	for i := 0; i < numCourses; i++{
		pMap[i] = make([]int, 0)
	}
	
	for i := 0; i < len(prerequisites); i++{
		c, p := prerequisites[i][0], prerequisites[i][1]
		pMap[c] = append(pMap[c], p)
	}
	
	visited := map[int]bool{}
	var dfs func(curr int) bool
	
	dfs = func(curr int) bool {
		if visited[curr]{
			return false
		}
	
		if len(pMap[curr]) == 0 {
			return true
		}
	
		visited[curr] = true
		for _, p := range pMap[curr]{
			if !dfs(p){
				return false
			}
		}
	
		visited[curr] = false
		pMap[curr] = []int{}
	
		return true
	}
	
	for i := 0; i < numCourses; i++{
		if !dfs(i){
			return false
		}
	}
	return true
}
```


---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/course-schedule/)
