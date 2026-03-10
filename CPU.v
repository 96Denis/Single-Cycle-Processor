module CPU (
    input clk,
    input rst
);
    //outputs from all the modules
    wire [15:0] pc;
    wire [15:0] instruction;
    wire [3:0]  mem_read_data;
    wire [3:0]  alu_opcode;
    wire [3:0]  reg_data1;
    wire [3:0]  reg_data2;
    wire [2:0]  reg_write_dest;
    wire [2:0]  reg_read_src1;
    wire [2:0]  reg_read_src2;
    wire [4:0]  alu_result;
    wire        zero;
    wire        overflow;
    wire        carry;
    wire        mem_write;
    wire        mem_read;
    wire        reg_write_enable;

    //instantiate all the modules
    program_counter PC (
        .clk(clk),
        .rst(rst),
        .jump(1'b0), // for now, no jumps 
        .jump_address(16'b0), //
        .pc(pc)
    );

    ROM ROM (
        .address(pc),
        .instruction(instruction)
    );

    decoder DEC (
        .instruction(instruction),
        .alu_opcode(alu_opcode),
        .reg_write_dest(reg_write_dest),
        .reg_read_src1(reg_read_src1),
        .reg_read_src2(reg_read_src2),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .write_enable(reg_write_enable)
    );

    register_file REG (
        .clk(clk),
        .rst(rst),
        .read_reg1(reg_read_src1),
        .read_reg2(reg_read_src2),
        .write_reg(reg_write_dest),
        .write_data(alu_result[3:0]), 
        .write_enable(reg_write_enable),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    ALU ALU (
        .a(reg_data1),
        .b(reg_data2),
        .opcode(alu_opcode),
        .result(alu_result),
        .zero(zero),
        .overflow(overflow),
        .carry(carry)
    );

    RAM RAM (
        .clk(clk),
        .address({12'b0, alu_result[3:0]}), 
        .write_data(reg_data2), 
        .mem_write(mem_write), 
        .mem_read(mem_read), 
        .read_data(mem_read_data)
    );

endmodule // CPU