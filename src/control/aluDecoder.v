module aluDecoder(
    input [1:0] ALUOp,
    input [6:0] op, 
    input [6:0] funct7,
    input [2:0] funct3,
    output reg [2:0] ALUControl

);



always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // For lw/sw -> ADD
            2'b01: ALUControl = 3'b001; // For beq -> SUB
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl = (funct7 == 7'b0100000) ? 3'b001 : 3'b000; // SUB : ADD
                    3'b010: ALUControl = 3'b101; // SLT
                    3'b100: ALUControl = 3'b100; // XOR
                    3'b110: ALUControl = 3'b011; // OR
                    3'b111: ALUControl = 3'b010; // AND
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end                                   
endmodule


