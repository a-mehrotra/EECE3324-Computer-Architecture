`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: ID_EX_DFF
// Description: D Flip-Flop from instruction decode to execute stage
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module ID_EX_DFF(RegOut1, RegOut2_ID, Imm_ID, S_ID, Cin_ID, SW_ID, LW_ID, BEQ_ID, BNE_ID, BLT_ID, BGE_ID, shamt_ID,
                 CBZ_ID, CBNZ_ID, SetFlag_ID, extender_out_ID, Dsel_ID, clk, ALUInput1, RegOut2_EX, S_EX, Imm_EX, SW_EX, 
                 LW_EX, Cin_EX, Dsel_EX, extender_out_EX, BEQ_EX, BNE_EX, BLT_EX, BGE_EX, CBZ_EX, CBNZ_EX, shamt_EX, SetFlag_EX,
                 r_type_ID, r_type_EX, shamt_ins_ID, shamt_ins_EX);
                 
    input BEQ_ID, BNE_ID, BLT_ID, BGE_ID, CBZ_ID, CBNZ_ID, SetFlag_ID, clk, Imm_ID, Cin_ID, SW_ID, LW_ID, r_type_ID, shamt_ins_ID;
    input[2:0] S_ID;
    input[5:0] shamt_ID;
    input[31:0] Dsel_ID;
    input[63:0] RegOut1, RegOut2_ID, extender_out_ID;
    output reg BEQ_EX, BNE_EX, BLT_EX, BGE_EX, CBZ_EX, CBNZ_EX, SetFlag_EX, Imm_EX, SW_EX, LW_EX, Cin_EX, r_type_EX, shamt_ins_EX;
    output reg[2:0] S_EX;
    output reg[5:0] shamt_EX; 
    output reg[31:0] Dsel_EX; 
    output reg[63:0]  ALUInput1, RegOut2_EX, extender_out_EX;
    
    always@(posedge clk) begin 
        BEQ_EX = BEQ_ID;
        BNE_EX = BNE_ID;
        BLT_EX = BLT_ID;
        BGE_EX = BGE_ID;
        CBZ_EX = CBZ_ID;
        CBNZ_EX = CBNZ_ID;
        r_type_EX = r_type_ID;
        shamt_ins_EX = shamt_ins_ID;
        SetFlag_EX = SetFlag_ID;
        Imm_EX = Imm_ID;
        SW_EX = SW_ID;
        LW_EX = LW_ID;
        Cin_EX = Cin_ID;
        S_EX = S_ID;
        shamt_EX = shamt_ID;
        Dsel_EX = Dsel_ID;
        ALUInput1 = RegOut1;
        RegOut2_EX = RegOut2_ID;
        extender_out_EX = extender_out_ID;       
    end
endmodule
