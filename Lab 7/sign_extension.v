`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Sign Extension
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module sign_extension(ibus, sign_ext_out);
    //Declare inputs and outputs
    input[31:0] ibus;
    output[31:0] sign_ext_out;
    //Declare wires for intermediate values
    wire[15:0] ImmID = ibus[15:0];
    //Assign final result with ternary operation
    assign sign_ext_out = {{16{ImmID[15]}}, ImmID[15:0]};
   
endmodule
