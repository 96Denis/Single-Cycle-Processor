module tb_ROM();

    reg  [15:0] address;
    wire [15:0] instruction;

    ROM uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_ROM);

        // read instruction at address 0
        address = 16'd0;
        #10;
        $display("Address 0: %b (should be ADD R1,R2,R3)", instruction);

        // read instruction at address 1
        address = 16'd1;
        #10;
        $display("Address 1: %b (should be SUB R1,R2,R3)", instruction);

        // read instruction at address 2
        address = 16'd2;
        #10;
        $display("Address 2: %b (should be NOP)", instruction);

        // read out of program bounds
        address = 16'd10;
        #10;
        $display("Address 10 (empty): %b", instruction);

        $finish;
    end

endmodule // tb_ROM