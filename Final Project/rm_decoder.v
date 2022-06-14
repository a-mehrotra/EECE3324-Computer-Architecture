`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: rm_decoder 
// Description: Pulls out Rm values from r_type formats
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module rm_decoder(ibus, Bselect);
    input[31:0] ibus;
    output[31:0] Bselect;
    
    wire[4:0] rm_val = ibus[20:16];
    integer rm_int;
    
    always@(rm_val) begin
        rm_int = rm_val;
    end
        
    assign Bselect = 32'b1 << rm_int;  
endmodule
