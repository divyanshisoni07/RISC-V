module instr_mem(
    input [31:0] A,
    input rst,
    output [31:0] RD
);
    /// creating memory
    reg [31:0] Mem [1023:0];

    assign RD = (rst) ? 32'b0: Mem[A[31:2]];// doubt
    
    // initial begin 
        // $readmemh("memfile.hex", Mem);
    // end

    initial begin
    // --- I-type ---
    Mem[0]  = 32'h00A00093; // addi x1, x0, 10       ; x1 = 10
    Mem[1]  = 32'h01400113; // addi x2, x0, 20       ; x2 = 20

    // --- R-type ---
    Mem[2]  = 32'h002081B3; // add x3, x1, x2        ; x3 = x1 + x2 = 30
    Mem[3]  = 32'h40110233; // sub x4, x2, x1        ; x4 = x2 - x1 = 10
    Mem[4]  = 32'h0020F2B3; // and x5, x1, x2        ; x5 = x1 & x2 = 0
    Mem[5]  = 32'h0020E333; // or  x6, x1, x2        ; x6 = x1 | x2 = 30

    // --- I-type logic ---
    Mem[6]  = 32'h00F0C393; // xori x7, x1, 15       ; x7 = x1 ^ 15
    Mem[7]  = 32'h00517413; // andi x8, x2, 5        ; x8 = x2 & 5
    Mem[8]  = 32'h00516493; // ori  x9, x2, 5        ; x9 = x2 | 5

    // --- Memory access ---
    Mem[9]  = 32'h00302023; // sw x3, 0(x0)          ; MEM[0] = x3
    Mem[10] = 32'h00002503; // lw x10, 0(x0)         ; x10 = MEM[0] = 30
    
        // --- U-type ---
    Mem[11] = 32'h123458B7; // lui x17, 0x12345      ; x17 = 0x12345000
    Mem[12] = 32'h00001917; // auipc x18, 0x1        ; x18 = PC + 0x1000
    
    // --- Branching ---
    Mem[13] = 32'h00350463; // beq x10, x3, +8       ; skip next
    Mem[14] = 32'h06F00593; // addi x11, x0, 111     ; should be skipped

    Mem[15] = 32'h00209463; // bne x1, x2, +8       ; skip next
    Mem[16] = 32'h0DE00613; // addi x12, x0, 222     ; should be skipped

    // --- Jumps ---
//   

    Mem[17] = 32'h04C00793; // addi x15, x0, 76      ; x15 = 76
    Mem[18] = 32'h00078867; // jalr x16, x15, 0      ; jump to x15 + 0

    Mem[19] = 32'h008006EF; // jal x13, +8           ; jump 2 instructions forward
    Mem[20] = 32'h06300713; // addi x14, x0, 99      ; should be skipped
end

initial  begin
        $display("JAL Instruction @19 = %h", Mem[19]);
 
    end
endmodule


