`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: EX/MEM D Flip-Flop
// Project Name: Assignment 5
//////////////////////////////////////////////////////////////////////////////////


module EXMEMDFF(ALUOutput, mux1_out_EX, clk, dbus, Dselect);
    //Declare inputs and outputs
    input[31:0] ALUOutput, mux1_out_EX;
    input clk;
    output reg[31:0] dbus, Dselect;
    //Assign flip-flop values
    always @(posedge clk) begin
        dbus = ALUOutput;
        Dselect = mux1_out_EX;
    end
endmodule
