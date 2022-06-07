`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: PC Logic
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module PC(clk, reset, pc_in, pc_out);
    input clk, reset;
    input[31:0] pc_in; 
    output reg [31:0] pc_out; 
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 32'h00000000;
        end
        else if (clk) begin
            pc_out <= pc_in;
        end
    end 
    
endmodule
