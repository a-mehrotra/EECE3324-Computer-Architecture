`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: IF_ID_DFF
// Description: D Flip-Flop from instruction fetch to instruction decode stage
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module IF_ID_DFF(ibus_in, clk, PC_mux_in1, ibus_out, adder2_in1);
    input [31:0] ibus_in;
    input clk; 
    input [63:0] PC_mux_in1;
    output reg [31:0] ibus_out;
    output reg [63:0] adder2_in1;
    
    always@(posedge clk) begin
        ibus_out = ibus_in; 
        adder2_in1 = PC_mux_in1; 
    end
    
endmodule
