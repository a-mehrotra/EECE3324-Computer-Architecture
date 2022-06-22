`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: Branch_Check
// Description: Checks the RegFile outputs and opcode signals to see if a branch is needed
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module Branch_Check(RegOut1, RegOut2, N, Z, V, C, zcomp, nzcomp, BEQ, BNE, BLT, BGE, mux_sel, b_type);
    input[63:0] RegOut1, RegOut2;
    input N, Z, V, C, zcomp, nzcomp, BEQ, BNE, BLT, BGE, b_type;
    output reg mux_sel;
    
    always@(RegOut1, RegOut2, N, Z, V, C, zcomp, nzcomp, BEQ, BNE, BLT, BGE, b_type) begin 
        if(BLT && (N != V)) begin 
            mux_sel <= 1'b1;
        end 
        else if(BGE && (N == V)) begin
            mux_sel <= 1'b1;
        end
        else if(BEQ && (Z == 1)) begin 
            mux_sel <= 1'b1;
        end 
        else if(BNE && (Z == 0)) begin 
            mux_sel <= 1'b1;
        end
        else if(zcomp && (RegOut2 == 0)) begin
            mux_sel <= 1'b1;
        end 
        else if(nzcomp && (RegOut2 != 0)) begin
            mux_sel <= 1'b1;
        end
        else if(b_type) begin 
            mux_sel <= 1'b1;
        end
        else begin 
            mux_sel <= 1'b0;
        end
    end 
endmodule
