`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: MEM/WB D Flip-Flop
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module MEMWBDFF(daddrbus_in, databus_in, Dselect_in, clk, SW_in, LW_in, BEQ_in, BNE_in, daddrbus_out, databus_out, Dselect_out, LW_out);
     //Declare inputs and outputs
    input[31:0] daddrbus_in, databus_in, Dselect_in;
    input clk, SW_in, LW_in, BEQ_in, BNE_in;
    output reg[31:0] daddrbus_out, databus_out, Dselect_out;
    output reg LW_out; 
    //Assign flip-flop values
    always @(posedge clk) begin
        daddrbus_out = daddrbus_in;
        databus_out = databus_in;
        Dselect_out = (SW_in || BEQ_in || BNE_in) ? 32'h00000001 : Dselect_in;
        LW_out = LW_in;
    end

endmodule