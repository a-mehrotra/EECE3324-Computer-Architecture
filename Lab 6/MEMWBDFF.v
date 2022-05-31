`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: MEM/WB D Flip-Flop
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module MEMWBDFF(daddrbus_in, databus_in, Dselect_in, clk, LW_in, daddrbus_out, databus_out, Dselect_out, LW_out);
     //Declare inputs and outputs
    input[31:0] daddrbus_in, databus_in, Dselect_in;
    input clk, LW_in;
    output reg[31:0] daddrbus_out, databus_out, Dselect_out;
    output reg LW_out; 
    //Assign flip-flop values
    always @(posedge clk) begin
        daddrbus_out = daddrbus_in;
        databus_out = databus_in;
        Dselect_out = Dselect_in;
        LW_out = LW_in;
    end

endmodule
