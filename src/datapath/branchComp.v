module branchComp(
    input [2:0] funct3,
    input [31:0] rs1, rs2,
    input Zero, Negative,OverFlow,Carry,
    output reg takeBranch
);

    always @(*) begin
        case (funct3)
            3'b000: takeBranch = Zero;                      // BEQ
            3'b001: takeBranch = ~Zero;                     // BNE
            3'b100: takeBranch = (Negative != OverFlow);    // BLT
            3'b101: takeBranch = (Negative == OverFlow);    // BGE
            3'b110: takeBranch = ~Carry;                    // BLTU
            3'b111: takeBranch = Carry;                     // BGEU
            default: takeBranch = 1'b0;

        endcase
    end

endmodule


//            3'b000: takeBranch = Zero; // BEQ
//            3'b001: takeBranch = ~Zero; // BNE            
//            3'b100: takeBranch = ($signed(rs1) < $signed(rs2)); // blt
//            3'b101: takeBranch = ($signed(rs1) >= $signed(rs2)); // bge
//            3'b110: takeBranch = (rs1 < rs2); // bltu
//            3'b111: takeBranch = (rs1 >= rs2);// bgeu
//            default: takeBranch = 1'b0;
