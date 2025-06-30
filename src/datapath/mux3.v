`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 12:57:33
// Design Name: 
// Module Name: mux3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux3(
    input [31:0] a, b, c,
    input [1:0] sel,
    output reg [31:0] out
);
    always @(*) begin
        case(sel)
            2'b00: out = a;
            2'b01: out = b;
            2'b10,
            2'b11: out = c; // PC+4
        endcase
    end
endmodule
