module ImmGen(
    input [31:0] instr,
    input [6:0] opcode,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);

    always @(*) begin
        case (ImmSrc)
            2'b00: // I-type (lw, addi, etc.)
                ImmExt = {{20{instr[31]}}, instr[31:20]};

            2'b01: // S-type (sw)
                ImmExt = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            2'b10: // B-type (beq, bne, etc.)
                ImmExt = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

            2'b11: begin // U-type (lui, auipc) or J-type (jal)
                if (opcode == 7'b1101111) begin
                    // J-type (jal)
                    ImmExt = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
                end else begin
                    // U-type (lui, auipc)
                    ImmExt = {instr[31:12], 12'b0};
                end
            end

            default:
                ImmExt = 32'b0;
        endcase
    end
    
    

endmodule

