module tb_decoder ();

   reg [15:0] instruction;
    wire [3:0] alu_opcode;
    wire [2:0] reg_write_dest;
    wire [2:0] reg_read_src1;
    wire [2:0] reg_read_src2;
    wire write_enable;
    wire mem_read;
    wire mem_write;

    decoder uut (
        .instruction(instruction),
        .alu_opcode(alu_opcode),
        .reg_write_dest(reg_write_dest),
        .reg_read_src1(reg_read_src1),
        .reg_read_src2(reg_read_src2),
        .write_enable(write_enable),
        .mem_read(mem_read),
        .mem_write(mem_write)
    );

    initial begin
        $monitor("Time: %0t | Instruction: %b | ALU Opcode: %b | Dest: %b | Src1: %b | Src2: %b | WE: %b | MR: %b | MW: %b",
                 $time, instruction, alu_opcode, reg_write_dest, reg_read_src1, reg_read_src2, write_enable, mem_read, mem_write);

        // Test ADD (0000)
        instruction = 16'b0000_001_010_011_000; // opcode 0000, dest 001, src1 010, src2 011
        #10;

        // Test SUB (0001)
        instruction = 16'b0001_001_010_011_000;
        #10;

        // Test AND (0010)
        instruction = 16'b0010_001_010_011_000;
        #10;

        // Test OR (0011)
        instruction = 16'b0011_001_010_011_000;
        #10;

        // Test XOR (0100)
        instruction = 16'b0100_001_010_011_000;
        #10;

        // Test NOT (0101)
        instruction = 16'b0101_001_010_011_000;
        #10;

        // Test SHL (0110)
        instruction = 16'b0110_001_010_011_000;
        #10;

        // Test SHR (0111)
        instruction = 16'b0111_001_010_011_000;
        #10;

        // Test SLT (1000)
        instruction = 16'b1000_001_010_011_000;
        #10;

        // Test LW (1001)
        instruction = 16'b1001_001_010_011_000;
        #10;

        // Test SW (1010)
        instruction = 16'b1010_001_010_011_000;
        #10;

        // Test invalid opcode (1111)
        instruction = 16'b1111_001_010_011_000;
        #10;

        $finish;
    end

endmodule //tb_decoder