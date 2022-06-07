`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Modified multiplexer for Program Counter
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module PC_mux(input1, input2, ImmID, mux_output);
    input[31:0] input1, input2;
    input ImmID;
    output reg [31:0] mux_output;
    
    always@(input1, input2, ImmID) begin    
        assign mux_output = input1;
        if(ImmID) begin
            assign mux_output = input2; 
        end
    end
endmodule

