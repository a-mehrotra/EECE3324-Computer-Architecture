`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: Multiplexer 32-bit
// Project Name: Assignment 4
//////////////////////////////////////////////////////////////////////////////////


module mux32(rt, rd, ImmID, DselectID);
    input[31:0] rt, rd;
    input ImmID;
    output[31:0] DselectID;
    
    assign DselectID = ImmID ? rt:rd;
endmodule
