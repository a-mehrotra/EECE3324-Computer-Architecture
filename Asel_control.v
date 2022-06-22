`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Asel_control
// Description: Module to control the Asel input from decoders
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module Asel_control(rn_decoder_in, r_type, i_type, d_type, Asel);
    input[31:0] rn_decoder_in;
    input r_type, i_type, d_type;
    output[31:0] Asel;
    
    assign Asel = (r_type || i_type || d_type) ? rn_decoder_in : 32'bzzzzzzzz;
    
endmodule
