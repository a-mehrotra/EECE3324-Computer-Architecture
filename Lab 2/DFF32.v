`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sam Bolduc, Aryan Mehrotra
// 
// Create Date: 05/16/2022 10:28:37 AM
// Module Name: DFF32
// Project Name: Assignment 2
//
//////////////////////////////////////////////////////////////////////////////////


module DFF32(DFFInput32, DFFOutput32, clk);
    input[31:0] DFFInput32;
    output reg[31:0] DFFOutput32;
    input clk;

    always @(posedge clk) begin 
       DFFOutput32 = DFFInput32; 
    end
endmodule
