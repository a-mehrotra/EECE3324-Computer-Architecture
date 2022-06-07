`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: ID/EX D Flip-Flop
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module IDEXDFF(reg_out1, reg_out2, ImmID, SID, CinID, SWID, LWID, BEQ_ID, BNE_ID, sign_ext_ID, mux1_out_ID, clk, ALUInput1, mux2_in_EX, Sx, 
               ImmEX, SWEX, LWEX, CinEX, mux1_out_EX, sign_ext_EX, BEQ_EX, BNE_EX);
    //Declare inputs and outputs
    input[31:0] reg_out1, reg_out2, sign_ext_ID, mux1_out_ID;
    input ImmID, CinID, clk, SWID, LWID, BEQ_ID, BNE_ID;
    input[2:0] SID;
    output reg [31:0] ALUInput1, mux2_in_EX, mux1_out_EX, sign_ext_EX;
    output reg ImmEX, CinEX, SWEX, LWEX, BEQ_EX, BNE_EX;
    output reg [2:0] Sx; 
    //Assign flip-flop values
    always @(posedge clk) begin 
        ALUInput1 = reg_out1;
        mux2_in_EX = reg_out2; 
        mux1_out_EX = mux1_out_ID;
        sign_ext_EX = sign_ext_ID;
        ImmEX = ImmID;
        CinEX = CinID;
        Sx = SID; 
        SWEX = SWID;
        LWEX = LWID;
        BEQ_EX = BEQ_ID;
        BNE_EX = BNE_ID;
    end
endmodule
