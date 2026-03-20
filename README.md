# 8-bit CPU in Verilog

A simple 8-bit single-cycle CPU implemented in Verilog as a portfolio project.
Built from scratch, module by module, with individual testbenches for each component.

## Architecture
- 8-bit data path
- 16-bit instruction format
- 8 general-purpose registers (R0–R7)
- Harvard architecture (separate instruction and data memory)
- Single-cycle execution

## Modules
| Module | Description |
|--------|-------------|
| ALU | Arithmetic Logic Unit – 11 operations |
| Register File | 8 × 8-bit general-purpose registers |
| Decoder | Instruction decoder and control unit |
| Program Counter | 16-bit PC with jump support |
| ROM | Instruction memory (256 × 16-bit) |
| RAM | Data memory (256 × 8-bit) |
| CPU | Top-level integration of all modules |

## Instruction Format
```
[15:12] opcode (4 bits)
[11:9]  dst    (3 bits) - destination register
[8:6]   src1   (3 bits) - source register 1
[5:3]   src2   (3 bits) - source register 2
[2:0]   imm    (3 bits) - immediate value (used by LOADI)
```

## Supported Instructions
| Opcode | Mnemonic | Operation |
|--------|----------|-----------|
| 0000 | ADD    | dst = src1 + src2 |
| 0001 | SUB    | dst = src1 - src2 |
| 0010 | AND    | dst = src1 & src2 |
| 0011 | OR     | dst = src1 \| src2 |
| 0100 | XOR    | dst = src1 ^ src2 |
| 0101 | NOT    | dst = ~src1 |
| 0110 | SHL    | dst = src1 << src2 |
| 0111 | SHR    | dst = src1 >> src2 |
| 1000 | SLT    | dst = (src1 < src2) ? 1 : 0 |
| 1001 | LW     | dst = RAM[addr] |
| 1010 | SW     | RAM[addr] = src1 |
| 1011 | LOADI  | dst = imm (load 3-bit immediate value) |
| 1100 | JUMP   | PC = addr (unconditional jump) |

## Assembler
A simple assembler written in C translates `.asm` source files into `program.mem` binary files readable by the ROM.
```bash
cd assembler
gcc assembler.c -o assembler
.\assembler.exe program.asm ../program/program.mem
```

Example `program.asm`:
```asm
// load values and compute
LOADI R1, 5
LOADI R2, 3
ADD R3, R1, R2
SW R3, R0, R0
```

## Simulation
Tested using EDA Playground with Icarus Verilog 12.0.
Each module has an individual testbench covering normal operation, edge cases, and reset behavior.


## TODO
- [x] ~~`LOADI` instruction – load immediate value into register~~
- [x] ~~`JUMP` instruction – unconditional jump~~
- [x] ~~Assembler in C – translate `.asm` files to `program.mem` automatically~~
- [ ] `BEQ` instruction – branch if equal (conditional jump using zero flag)
- [ ] Overflow and carry flag implementation in ALU
- [ ] Demo program – fibonacci or factorial running on the CPU
- [ ] Logisim Evolution visual schematic
