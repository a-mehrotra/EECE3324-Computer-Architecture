`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: ALUIn2_control
// Description: Module to control ALU Input 2 depending on instruction type
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module ALUIn2_control(RegOut2_EX, shamt_EX, iw_type, mov_shamt_EX, extender_out_EX, r_type, shamt_ins, Imm_EX, ALUInput2);
    input r_type, shamt_ins, Imm_EX, iw_type;
    input[5:0] shamt_EX;
    input[63:0] RegOut2_EX, extender_out_EX, mov_shamt_EX;
    output reg[63:0] ALUInput2;
    
    always@(RegOut2_EX, shamt_EX, mov_shamt_EX, extender_out_EX, r_type, shamt_ins, Imm_EX) begin
        //LSR or LSL
        if(r_type & shamt_ins) begin
            ALUInput2 = shamt_EX;
        end
        //All other R-types
        else if(r_type) begin 
            ALUInput2 = RegOut2_EX;
        end
        else if(Imm_EX) begin 
            //MOVZ specifically
            if(iw_type) begin
                ALUInput2 = mov_shamt_EX;
            end
            //All other I-types
            else begin
                ALUInput2 = extender_out_EX;
            end
        end
        //Default
        else begin
                ALUInput2 = extender_out_EX;
        end
    end
endmodule
