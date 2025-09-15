---
title: SIMD
layout: idea
tags:
  - performance
  - computer-engineering
---

# Single instruction, multiple data

- operating on multiple pieces of data with a single instruction
- moving from ADD to PADDD
  - packed ADD dword
  - wide version of ADD

```asm
ADD a, input[i]
ADD b, input[i+1]
ADD c, input[i+2]
ADD d, input[i+3]
//
// can be translated to
//
PADDD [a,b,c,d], [input[i],input[i+1]input[i+2],input[i+3]]
```

- The CPU still needs to do the work, but we save the CPU a lot of overhead work
  that it would need to do otherwise if it needed to process 4 separate ADD
  instructions
- Assume that lane width is 32 bits
- SSE instructions
  - 128 bit
  - widely supported
  - 4 lanes
- AVX
  - 256 bit
  - uncommon
  - 8 lanes
- AVX-512
  - 512 bits
  - very rare
  - 16 lanes

- ugly looking intrinsics

```c
//
// SSE: 3.12 IPC
//
typedef unsigned int u32;
u32 __attribute__((target("ssse3"))) SingleSSE(u32 Count, u32 *Input) {
	__m128i Sum = _mm_setzero_si128();
	for(u32 Index = 0; Index < Count; Index += 4) {
		Sum = _mm_add_epi32(Sum, _mm_load_si128((__m128i *)&Input[Index]));
	}

	Sum = _mm_hadd_epi32(Sum, Sum);
	Sum = _mm_hadd_epi32(Sum, Sum);

	return _mm_cvtsi128_si32(Sum);
}
//
// AVX: 7.05 IPC
//
typedef unsigned int u32;
u32 __attribute__((target("avx2"))) SingleAVX(u32 Count, u32 *Input) {
	__m256i Sum = _mm256_setzero_si256();
	for(u32 Index = 0; Index < Count; Index += 8) {
		Sum = _mm256_add_epi32(Sum, _mm256_loadu_si256((__m256i *)&Input[Index]));
	}

	Sum = _mm256_hadd_epi32(Sum, Sum);
	Sum = _mm256_hadd_epi32(Sum, Sum);
	__m256i SumS = _mm256_permute2x128_si256(Sum, Sum, 1 | (1 << 4));
	Sum = _mm256_add_epi32(Sum, SumS);

	return _mm256_cvtsi256_si32(Sum);
}
```

- We can continue improving on this by breaking the serial dependency chain

```c
//
// Dual AVX: 9.44 IPC
//
typedef unsigned int u32;
u32 __attribute__((target("avx2"))) DualAVX(u32 Count, u32 *Input) {
	__m256i SumA = _mm256_setzero_si256();
	__m256i SumB = _mm256_setzero_si256();
	for(u32 Index = 0; Index < Count; Index += 16) {
		SumA = _mm256_add_epi32(SumA, _mm256_loadu_si256((__m256i *)&Input[Index]));
		SumB = _mm256_add_epi32(SumB, _mm256_loadu_si256((__m256i *)&Input[Index + 8]));
	}

	__m256i Sum = _mm256_add_epi32(SumA, SumB);

	Sum = _mm256_hadd_epi32(Sum, Sum);
	Sum = _mm256_hadd_epi32(Sum, Sum);
	__m256i SumS = _mm256_permute2x128_si256(Sum, Sum, 1 | (1 << 4));
	Sum = _mm256_add_epi32(Sum, SumS);

	return _mm256_cvtsi256_si32(Sum);
}
//
// Quad AVX: 11.00 IPC
//
typedef unsigned int u32;
u32 __attribute__((target("avx2"))) QuadAVX(u32 Count, u32 *Input) {
	__m256i SumA = _mm256_setzero_si256();
	__m256i SumB = _mm256_setzero_si256();
	__m256i SumC = _mm256_setzero_si256();
	__m256i SumD = _mm256_setzero_si256();
	for(u32 Index = 0; Index < Count; Index += 32) {
		SumA = _mm256_add_epi32(SumA, _mm256_loadu_si256((__m256i *)&Input[Index]));
		SumB = _mm256_add_epi32(SumB, _mm256_loadu_si256((__m256i *)&Input[Index + 8]));
		SumC = _mm256_add_epi32(SumC, _mm256_loadu_si256((__m256i *)&Input[Index + 16]));
		SumD = _mm256_add_epi32(SumD, _mm256_loadu_si256((__m256i *)&Input[Index + 24]));
	}

	__m256i SumAB = _mm256_add_epi32(SumA, SumB);
	__m256i SumCD = _mm256_add_epi32(SumC, SumD);
	__m256i Sum = _mm256_add_epi32(SumAB, SumCD);

	Sum = _mm256_hadd_epi32(Sum, Sum);
	Sum = _mm256_hadd_epi32(Sum, Sum);
	__m256i SumS = _mm256_permute2x128_si256(Sum, Sum, 1 | (1 << 4));
	Sum = _mm256_add_epi32(Sum, SumS);

	return _mm256_cvtsi256_si32(Sum);
}
//
// Quad Pointer AVX: 13.39 IPC
//
typedef unsigned int u32;
u32 __attribute__((target("avx2"))) QuadAVXPtr(u32 Count, u32 *Input) {
	__m256i SumA = _mm256_setzero_si256();
	__m256i SumB = _mm256_setzero_si256();
	__m256i SumC = _mm256_setzero_si256();
	__m256i SumD = _mm256_setzero_si256();

	Count /= 32;
	while(Count--) {
		SumA = _mm256_add_epi32(SumA, _mm256_loadu_si256((__m256i *)&Input[0]));
		SumB = _mm256_add_epi32(SumB, _mm256_loadu_si256((__m256i *)&Input[8]));
		SumC = _mm256_add_epi32(SumC, _mm256_loadu_si256((__m256i *)&Input[16]));
		SumD = _mm256_add_epi32(SumD, _mm256_loadu_si256((__m256i *)&Input[24]));

		Input += 32;
	}

	__m256i SumAB = _mm256_add_epi32(SumA, SumB);
	__m256i SumCD = _mm256_add_epi32(SumC, SumD);
	__m256i Sum = _mm256_add_epi32(SumAB, SumCD);

	Sum = _mm256_hadd_epi32(Sum, Sum);
	Sum = _mm256_hadd_epi32(Sum, Sum);
	__m256i SumS = _mm256_permute2x128_si256(Sum, Sum, 1 | (1 << 4));
	Sum = _mm256_add_epi32(Sum, SumS);

	return _mm256_cvtsi256_si32(Sum);
}
```
