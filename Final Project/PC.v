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
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 64'h0000000000000000;
        end
        else if (clk) begin
            pc_out <= pc_in;
        end
    end 
endmodule
