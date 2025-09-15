---
title: Intel 8086
layout: idea
tags:
  - performance
  - computer-engineering
---

# Intel 8086

During the age of the Intel 8086, a register was a physical storage on the
processor. Registers were 16 bits in size and you would move memory across a bus
into the register, execute some instructions, and then move that data back into
memory.

## Instruction Decoding

Instruction decoding is the translation of an instruction stream to the
electro-mechanical operations that the processor needs to perform. These
instructions are represented as a mnemonic, human friendly translation of the
operation. For example, MOV is an instruction that copies data to a register.

```asm
MOV AX BX
```

In this particular example, we are copying data from register `BX` into register
`AX`. This instruction is decoded into two bytes

```
|1|0|0|0|1|1|D W|mod| REG | RM |
|    8 bit      |    8 bit     |
```

- `100011` - The `MOV` instruction
- `DW` - Size of destination register; 8 bit or 16 bit
- `MOD` - Memory operation or a register operation
- `REG` - Register
- `RM` - Register or memory

## Register Naming

- `AX` is targeting all 16 bits
- `AH` is targeting the 8 high bits
- `AL` is targeting the 8 low bits
