`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: DFF32
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module DFF32(DFFInput32, DFFOutput32, clk);
    input[31:0] DFFInput32;
    output reg[31:0] DFFOutput32;
    input clk;

    always @(posedge clk) begin 
       DFFOutput32 = DFFInput32; 
    end
endmodule
