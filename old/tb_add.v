module tb_add;

    reg  [3:0] a, b;
    wire [4:0] sum;

    add uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        a = 4'd3; b = 4'd5;
        #10;
        $display("3 + 5 = %d", sum);

        a = 4'd7; b = 4'd7;
        #10;
        $display("7 + 7 = %d", sum);

        a = 4'd15; b = 4'd1;
        #10;
        $display("15 + 1 = %d", sum);

        $finish;
    end

endmodule //tb_add;