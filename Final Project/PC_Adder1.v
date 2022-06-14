`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: PC_Adder1
// Description: Adds 4 to the program counter
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module PC_Adder1(in_1, out_1);
    input[63:0] in_1;
    output[63:0] out_1; 
    
    assign out_1 = in_1 + 64'h0000000000000004;
endmodule
