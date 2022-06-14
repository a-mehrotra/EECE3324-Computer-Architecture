`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: rd_decoder 
// Description: Pulls out Rd/Rt values from r_type, i_type and d_type, cb_type and iw_type formats
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module rd_decoder(ibus, Dselect);
    input[31:0] ibus;
    output[31:0] Dselect;
    
    wire[4:0] rd_val = ibus[4:0];
    integer rd_int;
    
    always@(rd_val) begin
        rd_int = rd_val;
    end
        
    assign Dselect = 32'b1 << rd_int;  
endmodule
