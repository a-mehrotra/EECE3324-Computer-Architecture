`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: IF_ID_DFF
// Description: D Flip-Flop from instruction fetch to instruction decode stage
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module IF_ID_DFF(ibus_in, clk, PC_mux_in1, ibus_out, adder_in1);
    input [31:0] ibus_in;
    input clk; 
    input [63:0] PC_mux_in1;
    output [31:0] ibus_out;
    output [63:0] adder_in1;
    
    DFF_32bit IFID_32(.DFF_32Input(ibus_in), 
                      .clk(clk), 
                      .DFF_32Output(ibus_out));
                      
    DFF_64bit IFID_64(.DFF_64Input(PC_mux_in1), 
                      .clk(clk), 
                      .DFF_64Output(adder_in1));
endmodule
