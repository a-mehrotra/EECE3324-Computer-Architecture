`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2022 10:28:37 AM
// Design Name: 
// Module Name: DFF32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
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
