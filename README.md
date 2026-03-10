# 4-bit CPU in Verilog

A simple 4-bit CPU implemented in Verilog as a portfolio project.

## Architecture
- 4-bit data path
- 16-bit instruction format
- 8 general-purpose registers
- Harvard architecture (separate instruction and data memory)

## Modules
| Module | Description |
|--------|-------------|
| ALU | Arithmetic Logic Unit (ADD, SUB, AND, OR, XOR, NOT, SHL, SHR, SLT) |
| Register File | 8 x 4-bit registers |
| Decoder | Instruction decoder and control unit |
| Program Counter | 16-bit PC with jump support |
| ROM | Instruction memory (256 x 16-bit) |
| RAM | Data memory (256 x 4-bit) |
| CPU | Top-level integration |

## Instruction Format
```
[15:12] opcode | [11:9] dst | [8:6] src1 | [5:3] src2 | [2:0] unused
```

## Supported Instructions
| Opcode | Mnemonic | Operation |
|--------|----------|-----------|
| 0000 | ADD | dst = src1 + src2 |
| 0001 | SUB | dst = src1 - src2 |
| 0010 | AND | dst = src1 & src2 |
| 0011 | OR  | dst = src1 \| src2 |
| 0100 | XOR | dst = src1 ^ src2 |
| 0101 | NOT | dst = ~src1 |
| 0110 | SHL | dst = src1 << src2 |
| 0111 | SHR | dst = src1 >> src2 |
| 1000 | SLT | dst = (src1 < src2) ? 1 : 0 |
| 1001 | LW  | dst = RAM[addr] |
| 1010 | SW  | RAM[addr] = src1 |

## Simulation
Tested using EDA Playground with Icarus Verilog 12.0
