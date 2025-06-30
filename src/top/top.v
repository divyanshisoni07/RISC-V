module top(
    input clk,rst
);

    wire [31:0] PCw,ImmExt,Instr,ALUResult,SrcB,SrcA,
                ReadData,WriteData,PCplus4,Result,PCBranch,
                PCNext,jalrTarget;
    wire [2:0] funct3;
    wire [2:0] ALUControl;
    wire [6:0] funct7, opcode;
    wire [1:0] ImmSrc,ResultSrc;
    wire RegWrite,MemWrite,ALUSrc,Branch,Zero,takeBranch,Carry,OverFlow,Jump;
    

     // === Instruction Fields ===
    assign funct3 = Instr[14:12];
    assign funct7 = Instr[31:25];
    assign opcode = Instr[6:0];

    pc PC(
        .clk(clk),
        .rst(rst),
        .PC(PCw),
        .PCNext(PCNext)
    );

    PCSelector PCS(
        .PCw(PCw),
        .ImmExt(ImmExt),
        .SrcA(SrcA),
        .Branch(Branch),
        .opcode(opcode),
        .WriteData(WriteData),
        .Jump(Jump),
        .Zero(Zero), 
        .Negative(Negative),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .funct3(funct3),
        .PCNext(PCNext),
        .PCplus4(PCplus4),
        .takeBranch(takeBranch),
        .PCBranch(PCBranch),
        .jalrTarget(jalrTarget)
    );


    instr_mem IM(
        .rst(rst),
        .A(PCw),
        .RD(Instr)
    );

    regfile REGFILE (
        .rst(rst),
        .clk(clk),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WE3(RegWrite),
        .WD3(Result),
        .RD1(SrcA),
        .RD2(WriteData)
    );

    ImmGen immgen (
    .instr(Instr),
    .opcode(opcode),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);
//    mux MUXRALU (
//        .a(WriteData),
//        .b(ImmExt),
//        .s(ALUSrc),
//        .c(SrcB)
//    );
    
    assign SrcB = ALUSrc ? ImmExt : WriteData;



    alu ALU(
        .A(SrcA),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative)

    );

    data_mem DM(
        .clk(clk),
        .WE(MemWrite),
        .rst(rst),
        .WD(WriteData),
        .RD(ReadData),
        .A(ALUResult)
    );


    controlUnit CU (
        .op(opcode),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .Jump(Jump),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
        );


    // === Result MUX: ALU, Mem, PC+4 ===

    mux3 MUX_Result (
        .a(ALUResult),
        .b(ReadData),
        .c(PCplus4),
        .sel(ResultSrc), // Jump=1 → PC+4
        .out(Result)
    );
    
endmodule
    
//  mux3 module:    
//    always @(*) begin 
//        case(RSrc)
//            2'b00: Result = ALUResult;
//            2'b01: Result = ReadData;
//            2'b10: Result = PCplus4; // PC+4
//            default: 32'bx;
//        endcase
//    end