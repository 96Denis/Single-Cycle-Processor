module tb_reg_file ();

  reg clk;
  reg rst;
  reg write_enable;
  reg   [2:0] write_reg;
  reg   [3:0] write_data;
  reg   [2:0] read_reg1;
  reg   [2:0] read_reg2;
  wire  [3:0] read_data1;
  wire  [3:0] read_data2;

   register_file uut (
    .clk(clk),
    .rst(rst),
    .write_enable(write_enable),
    .write_reg(write_reg),
    .write_data(write_data),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .read_data1(read_data1),
    .read_data2(read_data2)
   );

   initial begin
    clk = 0;
    forever #5 clk = ~clk;
   end

   initial begin
    rst = 1;
    write_enable = 0;
    write_reg = 0;
    write_data = 0;
    read_reg1 = 0;
    read_reg2 = 0;

    @(posedge clk); // wait for clock edge
    #1 rst = 0;     // release reset just after edge

    // Test 1: write 5 into R1
    @(posedge clk); #1;
    write_enable = 1;
    write_reg = 3'd1;
    write_data = 4'd5;

    @(posedge clk); #1; // wait for write to happen
    read_reg1 = 3'd1;
    $display("R1 should be 5, got: %d", read_data1);

    // Test 2: write 9 into R3
    @(posedge clk); #1;
    write_reg = 3'd3;
    write_data = 4'd9;

    @(posedge clk); #1;
    read_reg1 = 3'd3;
    $display("R3 should be 9, got: %d", read_data1);

    // Test 3: read two registers simultaneously
    read_reg1 = 3'd1;
    read_reg2 = 3'd3;
    #1;
    $display("R1=%d, R3=%d (should be 5 and 9)", read_data1, read_data2);

    // Test 4: reset clears everything
    @(posedge clk); #1;
    rst = 1;
    @(posedge clk); #1;
    @(posedge clk); #1;
    rst = 0;
    read_reg1 = 3'd1;
    read_reg2 = 3'd3;
    #1;
    $display("After reset - R1=%d, R3=%d (should be 0 and 0)", read_data1, read_data2);

    // Test 5: write disabled
    @(posedge clk); #1;
    write_enable = 0;
    write_reg = 3'd1;
    write_data = 4'd15;
    @(posedge clk); #1;
    read_reg1 = 3'd1;
    $display("Write disabled - R1 should be 0, got: %d", read_data1);

    $finish;
end
endmodule //tb_reg_file