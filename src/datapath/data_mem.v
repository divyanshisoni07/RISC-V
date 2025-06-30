module data_mem(
    input clk,WE,rst,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD
);

    reg [31:0] Mem [1023:0];
// write
    always @(posedge clk)
    begin
        if (WE)
            begin
                Mem[A[31:2]] <= WD;
            end
    end

// read

assign RD = (rst) ? 32'd0 : Mem[A[31:2]];



endmodule
