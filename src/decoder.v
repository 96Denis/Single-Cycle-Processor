module decoder (
    input [15:0] instruction,
    
    output [3:0] alu_opcode,
    output [2:0] reg_write_dest,
    output [2:0] reg_read_src1,
    output [2:0] reg_read_src2,
    output [2:0] immediate_value,
    output reg write_enable,
    output reg mem_read,
    output reg mem_write,
    output reg loadi_enable,
    output reg jump_enable
);
   assign alu_opcode = instruction[15:12];
   assign reg_write_dest = instruction[11:9];
   assign reg_read_src1 = instruction[8:6];
   assign reg_read_src2 = instruction[5:3];
   assign immediate_value = instruction[2:0];

   always @(*) begin
         case (alu_opcode)
            4'b0000: begin //ADD
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0001: begin //SUB
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0010: begin //AND
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0011: begin //OR
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0100: begin //XOR
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0101: begin //NOT
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0110: begin //SHL
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b0111: begin //SHR
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b1000: begin //SLT
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b1001: begin //LW
              write_enable = 1;
              mem_read = 1;
              mem_write = 0;
            end
            4'b1010: begin //SW
              write_enable = 0;
              mem_read = 0;
              mem_write = 1;
            end
            4'b1011: begin // LOADI
              write_enable = 1;
              mem_read = 0;
              mem_write = 0;
            end
            4'b1100: begin // JUMP
              write_enable = 0;
              mem_read = 0;
              mem_write = 0;
            end
            default: begin
              write_enable = 0;
              mem_read = 0;
              mem_write = 0;
            end
            endcase
    end
endmodule //decoder