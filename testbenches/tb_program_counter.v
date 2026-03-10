module tb_program_counter ();

    reg clk;
    reg rst;
    reg jump;
    reg [15:0] jump_address;
    wire [15:0] pc;

    program_counter uut (
        .clk(clk),
        .rst(rst),
        .jump(jump),
        .jump_address(jump_address),
        .pc(pc)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time: %0t | PC: %b | Jump: %b | Jump Address: %b | Reset: %b",
                 $time, pc, jump, jump_address, rst);

        rst = 1;
        jump = 0;
        jump_address = 16'b0;
        #10;

        // Test 1: reset sets PC to 0
        @(posedge clk); #1;
        rst = 0;
        $display("After reset - PC should be 0, got: %d", pc);

        // Test 2: normal increment
        @(posedge clk); #1;
        $display("PC should be 1, got: %d", pc);
        @(posedge clk); #1;
        $display("PC should be 2, got: %d", pc);
        @(posedge clk); #1;
        $display("PC should be 3, got: %d", pc);

        // Test 3: jump to address 10
        @(posedge clk); #1;
        jump = 1;
        jump_address = 16'd10;
        @(posedge clk); #1;
        $display("After jump - PC should be 10, got: %d", pc);

        // Test 4: disable jump, should increment from 10
        jump = 0;
        @(posedge clk); #1;
        $display("PC should be 11, got: %d", pc);
        @(posedge clk); #1;
        $display("PC should be 12, got: %d", pc);

        // Test 5: reset mid-execution
        rst = 1;
        @(posedge clk); #1;
        rst = 0;
        $display("After mid-reset - PC should be 0, got: %d", pc);

        $finish;
    end

endmodule // tb_program_counter

