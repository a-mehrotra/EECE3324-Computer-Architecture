`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: EX/MEM D Flip-Flop
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module EXMEMDFF(ALUOutput, mux1_out_EX, mux2_in_EX, SW_EX, LW_EX, BEQ_EX, BNE_EX, clk, dbus, Dselect, SW_MEM, LW_MEM, databus_in, BEQ_MEM, BNE_MEM);
    //Declare inputs and outputs
    input[31:0] ALUOutput, mux1_out_EX, mux2_in_EX;
    input clk, SW_EX, LW_EX, BEQ_EX, BNE_EX;
    output reg[31:0] dbus, Dselect, databus_in;
    output reg SW_MEM, LW_MEM, BEQ_MEM, BNE_MEM;
    //Assign flip-flop values
    always @(posedge clk) begin
        dbus = ALUOutput;
        Dselect = mux1_out_EX;
        databus_in = mux2_in_EX;
        SW_MEM = SW_EX;
        LW_MEM = LW_EX;
        BEQ_MEM = BEQ_EX;
        BNE_MEM = BNE_EX;
    end
endmodule
