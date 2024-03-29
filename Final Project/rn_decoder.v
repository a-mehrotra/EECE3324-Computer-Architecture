`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: rn_decoder 
// Description: Pulls out Rn values from r_type, i_type and d_type formats
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module rn_decoder(ibus, rn_out);
    input[31:0] ibus;
    output[31:0] rn_out;
    
    wire[4:0] rn_val = ibus[9:5];
    integer rn_int;
    
    always@(rn_val) begin
        rn_int = rn_val;
    end
        
    assign rn_out = 32'b1 << rn_int;  
endmodule
