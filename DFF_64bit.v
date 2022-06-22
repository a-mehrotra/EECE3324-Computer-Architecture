`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: DFF_32bit
// Description: D Flip-Flop which supports 64-bit values
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module DFF_64bit(DFF_64Input, clk, DFF_64Output);
    
    input[31:0] DFF_64Input;
    output reg[31:0] DFF_64Output;
    input clk;

    always @(posedge clk) begin 
       DFF_64Output = DFF_64Input; 
    end
endmodule

