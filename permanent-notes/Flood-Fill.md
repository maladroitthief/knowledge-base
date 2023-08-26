type: #idea
subject: [The-75-Questions](The-75-Questions.md)
<!-- Subject should be a hub note -->
# Flood-Fill

An image is represented by an `m x n` integer grid `image` where `image[i][j]` represents the pixel value of the image.

You are also given three integers `sr`, `sc`, and `color`. You should perform a **flood fill** on the image starting from the pixel `image[sr][sc]`.

To perform a **flood fill**, consider the starting pixel, plus any pixels connected **4-directionally** to the starting pixel of the same color as the starting pixel, plus any pixels connected **4-directionally** to those pixels (also with the same color), and so on. Replace the color of all of the aforementioned pixels with `color`.

Return _the modified image after performing the flood fill_.

## Method

DFS traversal and color as you go

## Solution

### go

```go
func floodFill(image [][]int, r int, c int, color int) [][]int {
	if image[r][c] != color{
		return dfs(image, sr, sc, image[r][c], color)
	}
	return image
}
func dfs(image [][]int, row, col, initColor, color int) [][]int {
	if image[row][col] != initColor {
		return image
	}
	image[row][col] = color
	if col+1 < len(image[row]) {
		image = dfs(image, row, col+1, initColor, color)
	}
	if col-1 >= 0 {
		image = dfs(image, row, col-1, initColor, color)
	}
	if row+1 < len(image) {
		image = dfs(image, row+1, col, initColor, color)
	}
	if row-1 >= 0 {
		image = dfs(image, row-1, col, initColor, color)
	}
	return image
}
```

---
# References
<!-- What references back up this idea -->
[Tech-Interview-Handbook](Tech-Interview-Handbook.md)
[LeetCode](https://leetcode.com/problems/flood-fill/)