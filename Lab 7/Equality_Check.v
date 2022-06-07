`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Equality Check 
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module Equality_Check(AOper_in, BOper_in, BEQ_ID, BNE_ID, AOper_out, BOper_out, branch_imm);
    input[31:0] AOper_in, BOper_in;
    input BEQ_ID, BNE_ID;
    output reg [31:0] AOper_out, BOper_out;
    output reg branch_imm; 
    
    always@(BEQ_ID or BNE_ID) begin
        if(BEQ_ID) begin 
            if(AOper_in == BOper_in) begin
                branch_imm <= 1;
                AOper_out <= AOper_in;
                BOper_out <= BOper_in;
            end
            else begin 
                branch_imm <= 0;
                AOper_out <= AOper_in;
                BOper_out <= BOper_in;
            end
         end
         else if(BNE_ID) begin
            if(AOper_in == BOper_in) begin
                branch_imm <= 0;
                AOper_out <= AOper_in;
                BOper_out <= BOper_in;
            end
            else begin 
                branch_imm <= 1;
                AOper_out <= AOper_in;
                BOper_out <= BOper_in;
            end
         end
     end
endmodule
