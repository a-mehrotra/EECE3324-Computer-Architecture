`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2022 04:04:36 PM
// Design Name: 
// Module Name: PC_mux
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


module PC_mux(mux_in1, mux_in2, sel, mux_out);
    //Input and output declaration
    input [63:0] mux_in1, mux_in2;
    input sel;
    output reg [63:0] mux_out; 
    
    //If select (sel) is 1, output mux_in2, otherwise output mux_in1
     always@(mux_in1, mux_in2, sel) begin    
        mux_out = mux_in1;
        if(sel) begin
             mux_out = mux_in1; 
        end
    end
endmodule
