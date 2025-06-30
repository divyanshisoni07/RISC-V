//module alu(
//    input [31:0]A,B,
//    input [2:0] ALUControl,
//    output Carry , OverFlow, Zero, Negative,
//    output [31:0]Result
//    );

//    wire Cout;
//    wire [31:0]Sum;

//    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
//                                          (A + ((~B)+1)) ;
//    assign Result = (ALUControl == 3'b000) ? Sum :
//                    (ALUControl == 3'b001) ? Sum :
//                    (ALUControl == 3'b010) ? A & B :
//                    (ALUControl == 3'b011) ? A | B :
//                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
//    assign OverFlow = ((Sum[31] ^ A[31]) & 
//                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
//                      (~ALUControl[1]));

//    assign Carry = ((~ALUControl[1]) & Cout);

//    assign Zero = &(~Result);
    
//    assign Negative = Result[31];

//endmodule

module alu(
    input [31:0] A, B,
    input [2:0] ALUControl,
    output Carry, OverFlow, Zero, Negative,
    output reg [31:0] Result
);

    wire Cout;
    wire [31:0] Sum;

    assign {Cout, Sum} = (ALUControl == 3'b001) ? (A - B) : (A + B);

    always @(*) begin
        case (ALUControl)
            3'b000: Result = A + B;        // ADD
            3'b001: Result = A - B;        // SUB
            3'b010: Result = A & B;        // AND
            3'b011: Result = A | B;        // OR
            3'b100: Result = A ^ B;        // XOR
            3'b101: Result = (A < B) ? 32'b1 : 32'b0; // SLT
            default: Result = 32'b0;
        endcase
    end

    assign OverFlow = (ALUControl == 3'b000 || ALUControl == 3'b001) ?
                      ((A[31] == B[31]) && (Result[31] != A[31])) : 1'b0;

    assign Carry = (ALUControl == 3'b000) ? Cout :
                   (ALUControl == 3'b001) ? ~Cout : 1'b0;

    assign Zero = (Result == 32'b0);
    assign Negative = Result[31];

endmodule

