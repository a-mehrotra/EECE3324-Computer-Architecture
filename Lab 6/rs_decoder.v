`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: RS Decoder
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module rs_decoder(ibus, Aselect);
    input[31:0] ibus;
    output[31:0] Aselect;
    
    wire[4:0] rs_val = ibus[25:21];
    integer rs_int;
    
    always@(rs_val) begin
        rs_int = rs_val;
    end
        
    assign Aselect = 32'b1 << rs_int;  
    
endmodule
