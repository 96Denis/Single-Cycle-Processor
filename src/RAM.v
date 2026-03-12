module RAM(
    input clk,
    input mem_write,
    input mem_read,
    input [15:0] address,
    input [7:0] write_data,
    output reg [7:0] read_data
);
    reg [7:0] memory [0:255];

    always @(*) begin
        if (mem_read) begin
            read_data = memory[address];
        end else begin
            read_data = 8'b0; 
        end
    end

    always @(posedge clk) begin
        if (mem_write) begin
            memory[address] <= write_data;
        end
    end
endmodule // RAM