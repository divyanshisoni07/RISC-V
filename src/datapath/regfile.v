//The regfile module is a simple register 
//file that can be used to store 
//and retrieve data.

// 32 elt 32 bit reg file

// read : A1,A2--> RD1, RD2
// write: A3 <-- WD3

module regfile(
    input [4:0] A1,A2,A3,
    input WE3, clk, rst,
    input [31:0] WD3,
    output [31:0] RD1,RD2
);

    reg [31:0] regfile [31:0];

// read // mux implemented
    assign RD1= (rst) ? 32'h0: regfile[A1];
    assign RD2=  (rst) ? 32'h0 : regfile[A2];


// write 
    always @(posedge clk)
    begin
     if (WE3 && A3 != 5'd0)
        begin
            regfile[A3]<= WD3;
        end
    end

    initial begin 
        regfile[0]=32'h00000000;
    end
endmodule


