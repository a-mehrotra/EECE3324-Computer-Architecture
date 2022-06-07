`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: DFF32
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module DFF32(DFFInput32, DFFInput32_2, DFFOutput32, DFFOutput32_2, clk);
    input[31:0] DFFInput32, DFFInput32_2;
    output reg[31:0] DFFOutput32, DFFOutput32_2;
    input clk;

    always @(posedge clk) begin 
       DFFOutput32 = DFFInput32; 
       DFFOutput32_2 = DFFInput32_2;
    end
endmodule
