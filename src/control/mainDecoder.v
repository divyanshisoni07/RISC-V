module mainDecoder(
    input [6:0] op,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0] ResultSrc,
    output reg ALUSrc,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ImmSrc,
    output reg [1:0] ALUOp
);

    always @(*) begin
        // Default values
        RegWrite   = 0;
        MemWrite   = 0;
        ResultSrc  = 2'b00;
        ALUSrc     = 0;
        Branch     = 0;
        Jump       = 0;
        ALUOp      = 2'b00;
        ImmSrc     = 2'b00;

        case (op)
            7'b0110011: begin // R-type
                RegWrite = 1;
                ALUSrc   = 0;
                ALUOp    = 2'b10;
            end

            7'b0010011: begin // I-type ALU (addi, xori, etc.)
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b10;
                ImmSrc   = 2'b00;
            end

            7'b0000011: begin // lw
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b00;
                ImmSrc    = 2'b00;
                ResultSrc= 2'b01;
            end

            7'b0100011: begin // sw
                MemWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b00;
                ImmSrc   = 2'b01;
            end

            7'b1100011: begin // B-type: beq, bne
                Branch  = 1;
                ALUSrc  = 0;
                ALUOp   = 2'b01;
                ImmSrc  = 2'b10;
            end

            7'b0110111: begin // lui
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b00;
                ImmSrc   = 2'b11;
            end

            7'b0010111: begin // auipc
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b00;
                ImmSrc   = 2'b11;
            end

            7'b1101111: begin // jal
                RegWrite = 1;
                Jump     = 1;
                ImmSrc   = 2'b11; // reuse B/J format
                ResultSrc = 2'b10; // PC+4
            end

            7'b1100111: begin // jalr
                RegWrite = 1;
                Jump     = 1;
                ALUSrc   = 1;
                ImmSrc   = 2'b00; // I-type format
                ResultSrc = 2'b10; // PC+4
            end

            default: ; // keep defaults
        endcase
    end
endmodule

