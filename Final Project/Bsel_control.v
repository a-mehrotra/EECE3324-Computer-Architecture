`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Bsel_control
// Description: Module to control Bselect input from decoders
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module Bsel_control(rd_decoder_in, rm_decoder_in, r_type, i_type, d_type, b_type, cb_type, iw_type, Bsel, Dsel_ID);
    input[31:0] rd_decoder_in, rm_decoder_in;
    input r_type, i_type, d_type, b_type, cb_type, iw_type;
    output reg[31:0] Bsel, Dsel_ID;
    
    always@(rd_decoder_in, rm_decoder_in, r_type, i_type, d_type, b_type, cb_type, iw_type) begin
        if(r_type) begin 
            Bsel = rm_decoder_in;
            Dsel_ID = rd_decoder_in;
        end
        else if(i_type || d_type || cb_type || iw_type) begin
             Bsel = 32'bzzzzzzzz;
             Dsel_ID = rd_decoder_in;
        end
        else if(b_type) begin
             Bsel = 32'bzzzzzzzz;
             Dsel_ID = 32'b00000000;
        end
    end
endmodule
