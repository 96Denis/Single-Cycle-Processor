module tb_CPU();

    reg clk;
    reg rst;

    CPU uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_CPU);

        // reset
        rst = 1;
        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 0;

        $display("--- CPU started ---");

        // run 10 cycles and monitor PC + instruction
        repeat(10) begin
            @(posedge clk); #1;
           $display("PC: %0d | Instr: %b | src1: %0d | src2: %0d | data1: %0d | data2: %0d | ALU: %0d | WE: %b | dst: %0d",
                uut.pc,
                uut.instruction,
                uut.reg_read_src1,
                uut.reg_read_src2,
                uut.reg_data1,
                uut.reg_data2,
                uut.alu_result,
                uut.reg_write_enable,
                uut.reg_write_dest
            );
        end

        $finish;
    end

endmodule // tb_CPU