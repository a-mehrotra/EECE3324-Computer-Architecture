`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: EX/MEM D Flip-Flop
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module EXMEMDFF(ALUOutput, mux1_out_EX, mux2_in_EX, SW_EX, clk, dbus, Dselect, SW_MEM, databus_in);
    //Declare inputs and outputs
    input[31:0] ALUOutput, mux1_out_EX, mux2_in_EX;
    input clk, SW_EX;
    output reg[31:0] dbus, Dselect, databus_in;
    output reg SW_MEM;
    //Assign flip-flop values
    always @(posedge clk) begin
        dbus = ALUOutput;
        Dselect = mux1_out_EX;
        databus_in = mux2_in_EX;
        SW_MEM = SW_EX;
    end
endmodule
