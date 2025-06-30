module controlUnit(op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl,Jump);

    input [6:0]op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,Branch,Jump;
    output [1:0] ResultSrc;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;

    mainDecoder MD(
                .op(op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .Jump(Jump),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    aluDecoder ALUD(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(op),
                            .ALUControl(ALUControl)
    );


endmodule