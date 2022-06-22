`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: shamt 
// Description: Pulls out shift amount from R-Type instructions
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module shamt(ibus, shamt_out);
    input[31:0] ibus;
    output[5:0] shamt_out;
    
    assign shamt_out = ibus[15:10];
endmodule
