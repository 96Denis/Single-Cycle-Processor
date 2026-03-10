module tb_ALU ();

    reg clk;
    reg rst;
    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] opcode;
    wire [4:0] result;
    wire zero;
    wire carry;
    wire overflow;
    
    ALU uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        #10 rst = 0;
        
       // ADD
    a = 4'd5; b = 4'd3; opcode = 4'b0000;
    #10;

    // SUB
    a = 4'd5; b = 4'd3; opcode = 4'b0001;
    #10;

    // AND
    a = 4'b1100; b = 4'b1010; opcode = 4'b0010;
    #10;

    // OR
    a = 4'b1100; b = 4'b1010; opcode = 4'b0011;
    #10;

    // XOR
    a = 4'b1100; b = 4'b1010; opcode = 4'b0100;
    #10;

    // NOT
    a = 4'b1010; b = 4'd0; opcode = 4'b0101;
    #10;

    // SLT: 3 < 5 = 1
    a = 4'd3; b = 4'd5; opcode = 4'b1000;
    #10;

        #100 $finish;
    end
    
    initial begin
      $monitor("Time: %0t | a: %h | b: %h | opcode: %b | result: %h | zero: %b | overflow: %b | carry: %b",
                         $time, a, b, opcode, result, zero, overflow, carry);
    end

endmodule //tb_ALU