`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: EX_MEM_DFF
// Description: D Flip-Flop from execute stage to memory stage
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module EX_MEM_DFF(ALUOutput, Dsel_EX, RegOut2_EX, SW_EX, LW_EX, BEQ_EX, BNE_EX, BLT_EX, BGE_EX, zcomp_EX, nzcomp_EX,
                  clk, daddrbus, Dsel_MEM, SW_MEM, LW_MEM, databus_in, BEQ_MEM, BNE_MEM, BLT_MEM, BGE_MEM, zcomp_MEM, nzcomp_MEM);
    //Declare inputs and outputs
    input[31:0] Dsel_EX;
    input[63:0] ALUOutput, RegOut2_EX;
    input clk, SW_EX, LW_EX, BEQ_EX, BNE_EX, BLT_EX, BGE_EX, zcomp_EX, nzcomp_EX;
    output reg[31:0] Dsel_MEM; 
    output reg[63:0] daddrbus, databus_in;
    output reg SW_MEM, LW_MEM, BEQ_MEM, BNE_MEM, BLT_MEM, BGE_MEM, zcomp_MEM, nzcomp_MEM;
                      
   always @(posedge clk) begin
        SW_MEM = SW_EX;
        LW_MEM = LW_EX;
        BEQ_MEM = BEQ_EX;
        BNE_MEM = BNE_EX;
        BLT_MEM = BLT_EX;
        BGE_MEM = BGE_EX;
        zcomp_MEM = zcomp_EX;
        nzcomp_MEM = nzcomp_EX;
        Dsel_MEM = Dsel_EX;
        databus_in = RegOut2_EX;
        daddrbus = ALUOutput;
    end  
endmodule
