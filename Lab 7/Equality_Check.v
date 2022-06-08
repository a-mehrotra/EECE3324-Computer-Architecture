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
    
    always@(BEQ_ID, BNE_ID, AOper_in, BOper_in) begin
         AOper_out = AOper_in;
         BOper_out = BOper_in;
         if(AOper_in == BOper_in && BEQ_ID) begin
             branch_imm <= 1;
         end
         else if(AOper_in != BOper_in && BNE_ID) begin 
             branch_imm <= 1;
         end
         else begin 
            branch_imm <= 0;
         end
      end
endmodule
