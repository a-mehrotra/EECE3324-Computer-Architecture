`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: mux64
// Description: 2 x 1 multiplexer which takes in 2 64-bit inputs
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module mux64(mux_in1, mux_in2, sel, mux_out);
    //Input and output declaration
    input [63:0] mux_in1, mux_in2;
    input sel;
    output [63:0] mux_out; 
    
    //If select (sel) is 1, output mux_in2, otherwise output mux_in1
    assign mux_out = sel ? mux_in2 : mux_in1;
    
endmodule
