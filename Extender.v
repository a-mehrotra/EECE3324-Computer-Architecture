`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Extender
// Description: Zero extends or sign extends immidiates or branch addresses
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module Extender(ibus, i_type, d_type, b_type, cb_type, iw_type, mov_shamt, extender_out);
    input[31:0] ibus;
    input i_type, d_type, b_type, cb_type, iw_type;
    output reg [63:0] extender_out, mov_shamt;
    
    reg[11:0] ALU_Imm;
    reg[25:0] BR_address;
    reg[15:0] MOV_immediate;
    
    always@(ibus, i_type, d_type, b_type, cb_type, iw_type) begin 
        if(i_type) begin
            ALU_Imm = ibus[21:10];
            mov_shamt = {58'b0 , ibus[22:21] << 4};
            extender_out = {52'b0, ALU_Imm};
        end
        if(d_type) begin
            mov_shamt = {58'b0 , ibus[22:21] << 4};
            extender_out = {{55{ibus[20]}}, ibus[20:12]};
        end
        if(b_type) begin
            mov_shamt = {58'b0 , ibus[22:21] << 4};
            extender_out = {{36{ibus[25]}}, ibus[25:0], 2'b0};
        end
        if(cb_type) begin
            mov_shamt = {58'b0 , ibus[22:21] << 4};
            extender_out = {{43{ibus[23]}}, ibus[23:5], 2'b0};
        end
        if(iw_type) begin
            MOV_immediate = ibus[20:5];
            mov_shamt = {58'b0 , ibus[22:21] << 4}; 
            extender_out = {48'b0, MOV_immediate};
        end
    end
endmodule
