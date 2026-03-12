module ALU(
    input [3:0] a,
    input [3:0] b,
    input [3:0] opcode,
    output reg [4:0] result,
    output zero,
    output overflow,
    output carry
);

    always @(*) begin
        case(opcode)
            4'b0000: result = a + b;           // ADD
            4'b0001: result = a - b;           // SUB
            4'b0010: result = a & b;           // AND
            4'b0011: result = a | b;           // OR
            4'b0100: result = a ^ b;           // XOR
            4'b0101: result = ~a;              // NOT
            4'b0110: result = a << b[2:0];     // SHL
            4'b0111: result = a >> b[2:0];     // SHR
            4'b1000: result = (a < b) ? 1 : 0; // SLT
            default: result = 4'b0;
        endcase
    end

    assign zero = (result == 5'b0);
    assign overflow = 1'b0; // impl later
    assign carry = 1'b0;    // impl later

endmodule //ALU