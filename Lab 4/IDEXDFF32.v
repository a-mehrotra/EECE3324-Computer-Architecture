`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: D Flip-Flop ID/EX
// Project Name: Assignment 4
//////////////////////////////////////////////////////////////////////////////////


module IDEXDFF32(DselectID, ImmID, SID, CinID, DselectEx, Imm, S, Cin, clk);
    input[31:0] DselectID;
    input[2:0] SID;
    input ImmID, CinID, clk;
    output reg[31:0] DselectEx;
    output reg[2:0] S;
    output reg Imm, Cin; 
    
    always @(posedge clk) begin 
       DselectEx = DselectID; 
       Imm = ImmID;
       S = SID;
       Cin = CinID;
    end 
endmodule
