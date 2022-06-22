`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: MEM_WB_DFF
// Description: D Flip-Flop from memory stage to write-back stage
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB_DFF(daddrbus_in, databus_in, Dselect_in, clk, SW_in, LW_in, BEQ_in, BNE_in, BLT_in, BGE_in, 
                  zcomp_in, nzcomp_in, daddrbus_out, databus_out, Dselect_out, LW_out);
    //Declare inputs and outputs
    input[31:0] Dselect_in;
    input[63:0] daddrbus_in, databus_in;
    input clk, SW_in, LW_in, BEQ_in, BNE_in, BLT_in, BGE_in, zcomp_in, nzcomp_in;
    output reg[31:0] Dselect_out;
    output reg[63:0] daddrbus_out, databus_out;
    output reg LW_out; 
    
    
    
    always @(posedge clk) begin
        Dselect_out = (SW_in || BEQ_in || BNE_in || BLT_in || BGE_in || zcomp_in || nzcomp_in) ? 32'h80000000 : Dselect_in;
        LW_out = LW_in;
        databus_out = databus_in;
        daddrbus_out = daddrbus_in;
    end
    
endmodule
