module register_file(
    // 8 registers, each 4 bits wide
    input clk,
    input rst,
    input write_enable,
    input  [2:0] write_reg,
    input  [3:0] write_data,
    input  [2:0] read_reg1,
    input  [2:0] read_reg2,
    output [3:0] read_data1,
    output [3:0] read_data2
);

    reg [3:0] registers [7:0];

    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    always @(posedge clk or posedge rst) begin
        integer i;
        if(rst) begin
            for(i = 0; i < 8; i = i + 1)
            registers[i] <= 4'b0000;
        end else if (write_enable) begin
            registers[write_reg] <= write_data;
        end
    end

endmodule //register_file