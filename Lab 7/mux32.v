`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Multiplexer 32-bit
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module mux32(input1, input2, ImmID, mux_output);
    input[31:0] input1, input2;
    input ImmID;
    output[31:0] mux_output;
    
    assign mux_output = ImmID ? input2:input1;
endmodule
