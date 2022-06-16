`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Data_Mem
// Description: Tri-State Buffer for databus access to data memory 
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module Data_Mem(b_oper, databus, SW_MEM);
    inout[31:0] databus;
    input[31:0] b_oper;
    input SW_MEM;
    
    assign databus = SW_MEM ?  b_oper : 32'bz;
    
endmodule
