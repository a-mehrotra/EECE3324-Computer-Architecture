`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: RD Decoder
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module rd_decoder(ibus, mux_rd);
    input[31:0] ibus;
    output[31:0] mux_rd;
    
    wire[4:0] rd_val = ibus[15:11];
    integer rd_int;
    
    always@(rd_val) begin
        rd_int = rd_val;
    end
        
    assign mux_rd = 32'b1 <<< rd_int;  
    
endmodule

