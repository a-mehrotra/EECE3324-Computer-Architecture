`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: RT Decoder
// Project Name: Assignment 4
//////////////////////////////////////////////////////////////////////////////////


module rt_decoder(ibus, Bselect);
    input[31:0] ibus;
    output[31:0] Bselect;
    
    wire[4:0] rt_val = ibus[20:16];
    integer rt_int;
    
    always@(rt_val) begin
        rt_int = rt_val;
    end
        
    assign Bselect = 32'b1 << rt_int;  
    
endmodule
