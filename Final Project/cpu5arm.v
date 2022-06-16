`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: cpu5arm
// Description: Top file for ARM LEGV8 CPU
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////

module cpu5arm(ibus, clk, reset, iaddrbus, daddrbus, databus);
    //Instantiate Inputs and Outputs
    input [31:0] ibus;
    input clk, reset;
    output [63:0] iaddrbus, daddrbus, databus;
    //Instantiate intermediate wires 
    wire branch_sel, N, Z, V, C, i_type_ID, d_type_ID, b_type_ID, cb_type_ID, iw_type_ID, r_type_ID, r_type_EX, 
         SW_ID, LW_ID, SW_EX, LW_EX, SW_MEM, LW_MEM, LW_WB, Imm_ID, Imm_EX, Cin_ID, Cin_EX, SetFlag_ID, SetFlag_EX, 
         BEQ_ID, BNE_ID, BLT_ID, BGE_ID, CBZ_ID, CBNZ_ID, BEQ_EX, BNE_EX, BLT_EX, BGE_EX, CBZ_EX, CBNZ_EX,
         BEQ_MEM, BNE_MEM, BLT_MEM, BGE_MEM, CBZ_MEM, CBNZ_MEM, shamt_ins_ID, shamt_ins_EX; 
    wire [2:0] S_ID, S_EX;
    wire [5:0] shamt_out_ID, shamt_out_EX;
    wire [31:0] ibus_out, rn_out, rd_out, rm_out, RegIn1, RegIn2, Dsel_ID, DSel_EX, DSel_MEM, DSel;
    wire [63:0] PC_mux1, PC_mux2, PC_muxout, Adder2_input, extender_out_ID, extender_out_EX, RegOut1, RegOut2_ID, 
                RegOut2_EX, RegOut2_MEM, ALUInput1, ALUInput2, ALUOutput, DataSel_mux1, DataSel_mux2, dbus;
    
    //Instantiate Program Counter 
    PC program(.clk(clk), 
               .reset(reset), 
               .pc_in(PC_muxout), 
               .pc_out(iaddrbus));
    //Instantiate Adder 1 (PC + 4)
    PC_Adder1 PC_Adder1(.in_1(iaddrbus), 
                        .out_1(PC_mux1));
    //Instantiate IF/ID D Flip-Flop
    IF_ID_DFF IF_ID_DFF(.ibus_in(ibus), 
                        .clk(clk), 
                        .PC_mux_in1(iaddrbus), 
                        .ibus_out(ibus_out), 
                        .adder2_in1(Adder2_input));
    //Instantiate opcode_decoder
    opcode_decoder opcode_decoder(.ibus(ibus_out), 
                                  .S_ID(S_ID), 
                                  .Cin_ID(Cin_ID), 
                                  .Imm_ID(Imm_ID),
                                  .SetFlag_ID(SetFlag_ID), 
                                  .SW_ID(SW_ID), 
                                  .LW_ID(LW_ID), 
                                  .r_type(r_type_ID),
                                  .i_type(i_type_ID), 
                                  .d_type(d_type_ID), 
                                  .b_type(b_type_ID), 
                                  .cb_type(cb_type_ID), 
                                  .iw_type(iw_type_ID),
                                  .zcomp(CBZ_ID), 
                                  .nzcomp(CBNZ_ID), 
                                  .BEQ(BEQ_ID), 
                                  .BNE(BNE_ID), 
                                  .BLT(BLT_ID), 
                                  .BGE(BGE_ID),
                                  .shamt_ins(shamt_ins_ID));
    //Instantiate rn_decoder
    rn_decoder rn_decoder(.ibus(ibus_out), 
                          .rn_out(rn_out));
    //Module to select RegFile Input 1
    Asel_control Asel_control(.rn_decoder_in(rn_out), 
                              .r_type(r_type_ID), 
                              .i_type(i_type_ID), 
                              .d_type(d_type_ID), 
                              .Asel(RegIn1));
    //Instantiate rd_decoder
    rd_decoder rd_decoder(.ibus(ibus_out), 
                          .rd_out(rd_out));
    //Instantiate rm_decoder
    rm_decoder rm_decoder(.ibus(ibus_out), 
                          .rm_out(rm_out));
    //Module to select RegFile Input 2
    Bsel_control Bsel_control(.rd_decoder_in(rd_out), 
                              .rm_decoder_in(rm_out), 
                              .r_type(r_type_ID), 
                              .i_type(i_type_ID), 
                              .d_type(d_type_ID), 
                              .b_type(b_type_ID), 
                              .cb_type(cb_type_ID), 
                              .iw_type(iw_type_ID), 
                              .Bsel(RegIn2), 
                              .Dsel_ID(Dsel_ID));
    //Instantiate shamt_decoder
    shamt shamt(.ibus(ibus_out), 
                .shamt_out(shamt_out_ID));
    //Instantiate Extender
    Extender Extender(.ibus(ibus_out), 
                      .i_type(i_type_ID), 
                      .d_type(d_type_ID), 
                      .b_type(b_type_ID), 
                      .cb_type(cb_type_ID), 
                      .iw_type(iw_type_ID), 
                      .extender_out(extender_out_ID));
    //Instantiate Register File 
    RegFile RegFile(.Aselect(RegIn1), 
                    .Bselect(RegIn2), 
                    .Dselect(Dsel), 
                    .abus(RegOut1), 
                    .bbus(RegOut2_ID), 
                    .dbus(dbus), 
                    .clk(clk));
    //Instantiate BranchCheck 
    Branch_Check Branch_Check(.RegOut1(RegOut1), 
                              .RegOut2(RegOut2_ID), 
                              .N(N), 
                              .Z(Z), 
                              .V(V), 
                              .C(C), 
                              .zcomp(CBZ_ID), 
                              .nzcomp(CBNZ_ID), 
                              .BEQ(BEQ_ID), 
                              .BNE(BNE_ID), 
                              .BLT(BLT_ID), 
                              .BGE(BGE_ID), 
                              .mux_sel(branch_sel));
    //Instantiate Adder 2 (PC + Branch Address/Immediate)
    PC_Adder2 PC_Adder2(.in_1(Adder2_input), 
                        .in_2(extender_out_ID), 
                        .out_1(PC_mux2));
    //Instantiate PC Mux which outputs to PC DFF
    mux64 PC_mux(.mux_in1(PC_mux1), 
                 .mux_in2(PC_mux2), 
                 .sel(branch_sel), 
                 .mux_out(PC_muxout));
    //Instantiate ID_EX_DFF
    ID_EX_DFF ID_EX_DFF(.RegOut1(RegOut1), 
                        .RegOut2_ID(RegOut2_ID), 
                        .Imm_ID(Imm_ID), 
                        .S_ID(S_ID), 
                        .Cin_ID(Cin_ID), 
                        .SW_ID(SW_ID), 
                        .LW_ID(LW_ID), 
                        .BEQ_ID(BEQ_ID), 
                        .BNE_ID(BNE_ID), 
                        .BLT_ID(BLT_ID), 
                        .BGE_ID(BGE_ID), 
                        .r_type_ID(r_type_ID),
                        .shamt_ID(shamt_ID), 
                        .shamt_ins_ID(shamt_ins_ID),
                        .CBZ_ID(CBZ_ID), 
                        .CBNZ_ID(CBNZ_ID), 
                        .SetFlag_ID(SetFlag_ID), 
                        .extender_out_ID(extender_out_ID), 
                        .Dsel_ID(Dsel_ID), 
                        .clk(clk), 
                        .ALUInput1(ALUInput1), 
                        .RegOut2_EX(RegOut2_EX), 
                        .S_EX(S_EX), 
                        .Imm_EX(Imm_EX), 
                        .SW_EX(SW_EX), 
                        .LW_EX(LW_EX), 
                        .Cin_EX(Cin_EX), 
                        .Dsel_EX(Dsel_EX), 
                        .extender_out_EX(extender_out_EX), 
                        .BEQ_EX(BEQ_EX), 
                        .BNE_EX(BNE_EX), 
                        .BLT_EX(BLT_EX), 
                        .BGE_EX(BGE_EX), 
                        .CBZ_EX(CBZ_EX), 
                        .CBNZ_EX(CBNZ_EX),
                        .r_type_EX(r_type_EX), 
                        .shamt_EX(shamt_EX), 
                        .shamt_ins_EX(shamt_ins_EX),
                        .SetFlag_EX(SetFlag_EX));
    //Instantiate module to select ALU Input 2
    ALUIn2_control ALUIn2_control(.RegOut2_EX(RegOut2_EX), 
                                  .shamt_EX(shamt_EX), 
                                  .extender_out_EX(extender_out_EX), 
                                  .r_type(r_type_EX), 
                                  .shamt_ins(shamt_ins_EX), 
                                  .Imm_EX(Imm_EX), 
                                  .ALUInput2(ALUInput2));
    //Instantiate ALU
    ALU ALU(.ALU_abus(ALUInput1), 
            .ALU_bbus(ALUInput2), 
            .Cin(Cin_EX), 
            .S(S_EX), 
            .ALU_Out(ALUOutput), 
            .N(N), 
            .Z(Z), 
            .V(V), 
            .C(C));
    //Instantiate EX_MEM_DFF
    EX_MEM_DFF EX_MEM_DFF(.ALUOutput(ALUOutput), 
                          .Dsel_EX(Dsel_EX), 
                          .RegOut2_EX(RegOut2_EX), 
                          .SW_EX(SW_EX), 
                          .LW_EX(LW_EX), 
                          .BEQ_EX(BEQ_EX), 
                          .BNE_EX(BNE_EX), 
                          .BLT_EX(BLT_EX), 
                          .BGE_EX(BGE_EX), 
                          .zcomp_EX(zcomp_EX), 
                          .nzcomp_EX(nzcomp_EX), 
                          .clk(clk), 
                          .daddrbus(daddrbus), 
                          .Dsel_MEM(Dsel_MEM), 
                          .SW_MEM(SW_MEM), 
                          .LW_MEM(LW_MEM), 
                          .databus_in(RegOut2_MEM), 
                          .BEQ_MEM(BEQ_MEM), 
                          .BNE_MEM(BNE_MEM), 
                          .BLT_MEM(BLT_MEM), 
                          .BGE_MEM(BGE_MEM), 
                          .zcomp_MEM(zcomp_MEM), 
                          .nzcomp_MEM(nzcomp_MEM));
    //Instantiate tri-state buffer for databus
    Data_Mem Data_Mem(.b_oper(RegOut2_MEM), 
                      .databus(databus), 
                      .SW_MEM(SW_MEM));
    //Instantiate MEM_WB_DFF
    MEM_WB_DFF MEM_WB_DFF(.daddrbus_in(daddrbus), 
                          .databus_in(databus), 
                          .Dselect_in(Dsel_MEM), 
                          .clk(clk), 
                          .SW_in(SW_MEM), 
                          .LW_in(LW_MEM), 
                          .BEQ_in(BEQ_MEM), 
                          .BNE_in(BNE_MEM), 
                          .BLT_in(BLT_MEM), 
                          .BGE_in(BGE_MEM), 
                          .zcomp_in(zcomp_MEM), 
                          .nzcomp_in(nzcomp_MEM),
                          .daddrbus_out(DataSel_mux1), 
                          .databus_out(DataSel_mux2), 
                          .Dselect_out(Dsel), 
                          .LW_out(LW_WB));
    //Mux to select Dbus
    mux64 dbus_mux(.mux_in1(DataSel_mux1), 
                   .mux_in2(DataSel_mux2), 
                   .sel(LW_WB), 
                   .mux_out(dbus));
endmodule
