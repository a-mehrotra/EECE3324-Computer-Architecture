`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: DFF_32bit
// Description: D Flip-Flop which supports 32-bit values
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module DFF_32bit(DFF_32Input, clk, DFF_32Output);
    
    input[31:0] DFF_32Input;
    output reg[31:0] DFF_32Output;
    input clk;

    always @(posedge clk) begin 
       DFF_32Output = DFF_32Input; 
    end
endmodule
