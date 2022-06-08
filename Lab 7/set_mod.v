`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Module for SLT/SLE Operations
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module set_mod(SLT_in, SLE_in, ALUOutput_in, Cout, ALUOutput_out);
    input[31:0] ALUOutput_in;
    input SLT_in, SLE_in, Cout; 
    output reg [31:0] ALUOutput_out;
    
    wire Z;
   
    assign Z = (ALUOutput_in == 32'h00000000) ? 1 : 0; 
    
    always@(SLT_in, SLE_in, ALUOutput_in) begin 
        ALUOutput_out = ALUOutput_in;
        if(SLT_in && (!Cout && !Z)) begin 
            ALUOutput_out = 32'h00000001; 
        end
        else if(SLE_in &&(!Cout || Z)) begin 
            ALUOutput_out = 32'h00000001;
        end
    end
  
endmodule
