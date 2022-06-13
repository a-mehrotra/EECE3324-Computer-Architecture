`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: PC
// Description: Program Counter D Flip-Flop
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module PC(clk, reset, pc_in, pc_out);
    input [63:0] pc_in;
    input clk, reset;
    output reg [63:0] pc_out;
    
    always@(reset) begin 
        pc_out = 64'h0000000000000000;
    end 
    
    DFF_64bit PC_DFF(.DFF_64Input(pc_in), 
                     .clk(clk), 
                     .DFF_64Output(pc_out));
endmodule
