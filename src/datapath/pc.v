module pc(
    input clk, rst,
    input [31:0] PCNext,
    output reg [31:0] PC

);
    always @ (posedge clk)
    begin
        if(rst)
         begin
            PC <= 32'h00000000;
         end
        else
        begin
            PC <= PCNext;
        end
    end
endmodule
