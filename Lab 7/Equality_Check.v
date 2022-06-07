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
    output [31:0] AOper_out, BOper_out;
    output reg branch_imm; 
    
    always@(BEQ_ID) begin
         if(AOper_in == BOper_in) begin
             branch_imm <= 1;
         end
         else begin 
             branch_imm <= 0;
         end
      end
    always@(BNE_ID) begin
        if(AOper_in == BOper_in) begin
             branch_imm <= 0;
         end
         else begin 
             branch_imm <= 1;
         end
     end
     
     assign AOper_out = AOper_in;
     assign BOper_out = BOper_in;

endmodule
