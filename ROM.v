module ROM(
    input  [15:0] address,
    output [15:0] instruction
);

    reg [15:0] memory [0:255];

    initial begin
        $readmemb("program.mem", memory);
    end

    assign instruction = memory[address];
endmodule // ROM