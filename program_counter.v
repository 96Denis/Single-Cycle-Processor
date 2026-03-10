module program_counter (
    input clk,
    input rst,
    input jump,
    input [15:0] jump_address,
    output reg [15:0] pc
);

    always @(posedge clk or posedge rst) begin
        if(rst)
        pc <= 16'b0;
        else if (jump)
        pc <= jump_address;
        else
        pc <= pc + 1;
    end

endmodule // program_counter