`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: Sign Extension
// Project Name: Assignment 5
//////////////////////////////////////////////////////////////////////////////////


module sign_extension(ibus, sign_ext_out);
    //Declare inputs and outputs
    input[31:0] ibus;
    output[31:0] sign_ext_out;
    //Declare wires for intermediate values
    wire[15:0] ImmID = ibus[15:0];
    wire first = ibus[15];
    //Assign final result with ternary operation
    assign sign_ext_out = first ? {16'hFFFF, ImmID} : {16'h0000, ImmID};
   
endmodule
