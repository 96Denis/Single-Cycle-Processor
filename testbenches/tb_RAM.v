module tb_RAM ();

    reg clk;
    reg mem_write;
    reg mem_read;
    reg [15:0] address;
    reg [3:0] write_data;
    wire [3:0] read_data;

    RAM uut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time: %0t | Address: %b | Write Data: %b | Read Data: %b | Mem Write: %b | Mem Read: %b",
                 $time, address, write_data, read_data, mem_write, mem_read);

        // Test 1: Write to address 5 and read back
        address = 16'd5;
        write_data = 4'b1010;
        mem_write = 1; 
        mem_read = 0;  
        @(posedge clk); #1;

        mem_write = 0; 
        mem_read = 1;  
        @(posedge clk); #1;

        // Test 2: Write to address 10 and read back
        address = 16'd10;
        write_data = 4'b1100;
        mem_write = 1; 
        mem_read = 0;  
        @(posedge clk); #1;

        mem_write = 0; 
        mem_read = 1;  
        @(posedge clk); #1;

        // Test 3: Read from an unwritten address (should be 0 or x)
        address = 16'd15;
        mem_write = 0; 
        mem_read = 1;  
        @(posedge clk); #1;

        $finish;
    end
endmodule // tb_RAM