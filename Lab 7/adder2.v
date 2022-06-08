`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Adder Module - Type 2
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module adder2(in_1, in_2, out_1);
    input[31:0] in_1, in_2;
    output[31:0] out_1; 
    wire[31:0] shifted_input;
    
    assign shifted_input = in_2 << 2; 
        
    assign out_1 = in_1 + shifted_input;
endmodule
