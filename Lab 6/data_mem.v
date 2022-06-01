`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: Data Bus Assignment
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module data_mem(b_oper, databus, SW_MEM);
    inout[31:0] databus;
    input[31:0] b_oper;
    input SW_MEM;
    
    assign databus = SW_MEM ?  b_oper : 32'bz;
    
endmodule
