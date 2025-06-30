
module PCSelector(
    input [31:0] PCw,ImmExt,SrcA,WriteData,
    input [6:0] opcode,
    input Branch,Jump,Zero,Negative,OverFlow,Carry,
    input [2:0] funct3,
    output [31:0] PCplus4,PCNext,PCBranch,jalrTarget,
    output takeBranch
);
    
    assign PCplus4=PCw + 32'd4;
    assign PCBranch= PCw + ImmExt;
    assign jalrTarget = (SrcA+ImmExt) & ~32'b1;
//    assign PCJumpTarget = PCw + ImmExt;


    branchComp BC(
        .funct3(funct3),
        .rs1(SrcA),
        .rs2(WriteData),
        .Zero(Zero), 
        .Negative(Negative),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .takeBranch(takeBranch)
    );

    assign PCNext = Jump ? 
                ((opcode == 7'b1100111) ? jalrTarget : PCBranch) :
                ((Branch && takeBranch) ? PCBranch : PCplus4);
                
endmodule
               
                
//     PCadder PCadder1 (
//        .a(PCw),
//        .b(32'd4),
//        .c(PCplus4)
//    );

//    PCadder PCadder2 (
//        .a(PCw),
//        .b(ImmExt),
//        .c(PCBranch)
//    );

//    PCadder PCadder3(
//        .a(SrcA),
//        .b(ImmExt),
//        .c(Eff)
//    );


//assign PCNext = Jump ? 
//                ((opcode == 7'b1100111) ? jalrTarget : PCBranch) :
//                (Branch && takeBranch ? PCBranch : PCplus4);




//assign PCNext = Jump ? 
//                    ((opcode == 7'b1100111) ? jalrTarget : PCBranch) :
//                    (Branch ? 
//                        (takeBranch ? PCBranch : PCplus4) : 
//                        PCplus4);



