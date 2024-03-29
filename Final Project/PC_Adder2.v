`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: PC_Adder2
// Description: Adds branch offset to the program counter
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module PC_Adder2(in_1, in_2, out_1);
    input[63:0] in_1, in_2;
    output[63:0] out_1; 
        
    assign out_1 = in_1 + in_2;
endmodule
