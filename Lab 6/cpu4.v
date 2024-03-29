`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: 4-Stage CPU
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module cpu4(ibus, clk, daddrbus, databus);
    //Declare inputs and outputs
    input[31:0] ibus;
    input clk; 
    output[31:0] daddrbus;
    inout[31:0] databus;
    
    //Declare wires for intermediate values
    wire[31:0] decoderInput, Aselect, Bselect, rd_output, sign_ext_ID, regfile_out1, regfile_out2, Dselect_ID, Dselect_EX, sign_ext_EX, mux2_in_EX, ALUOutput, 
        Dselect, abus, bbus, dbus, mux3_in1, mux3_in2, Dselect_MEM, databus_in;
    wire[2:0] S_ID, S_EX;
    wire Imm_ID, Cin_ID, SW_ID, Imm_EX, Cin_EX, SW_EX, Cout, V, SW_MEM, SW_WB, LW_ID, LW_EX, LW_MEM, LW_WB;
    
    //IF/ID Flip-Flop Declaration
    DFF32 IFID_DFF(.DFFInput32(ibus), .DFFOutput32(decoderInput), .clk(clk));
    //Set-up rs decoder and output to Aselect
    rs_decoder rs_decoder(.ibus(decoderInput), .Aselect(Aselect));
    //Set-up rt decoder and output to Bselect and mux
    rt_decoder rt_decoder(.ibus(decoderInput), .Bselect(Bselect));
    //Set-up rd decoder and output to mux
    rd_decoder rd_decoder(.ibus(decoderInput), .mux_rd(rd_output));
    //Set-up opcode decoder and output to ID/EX DFF
    opcode_decoder opcode_decoder(.ibus(decoderInput), .ImmID(Imm_ID), .SID(S_ID), .CinID(Cin_ID), .SWID(SW_ID), .LWID(LW_ID));
    //Set-up mux to output Dselect to DFF
    mux32 mux1(.input1(rd_output), .input2(Bselect), .ImmID(Imm_ID), .mux_output(Dselect_ID));
    //Set-up sign extension module
    sign_extension sign_ext(.ibus(decoderInput), .sign_ext_out(sign_ext_ID));
    //Set-up register file 
    RegFile32x32 reg_file(.Aselect(Aselect), .Bselect(Bselect), .Dselect(Dselect), .abus(regfile_out1), .bbus(regfile_out2), .dbus(dbus), .clk(clk));
    //Set-up ID/EX D Flip-Flop
    IDEXDFF IDEX_DFF(.reg_out1(regfile_out1), .reg_out2(regfile_out2), .ImmID(Imm_ID), .SID(S_ID), .CinID(Cin_ID), .SWID(SW_ID), .sign_ext_ID(sign_ext_ID), 
                        .mux1_out_ID(Dselect_ID), .clk(clk), .ALUInput1(abus), .mux2_in_EX(mux2_in_EX), .Sx(S_EX), .ImmEX(Imm_EX), .SWEX(SW_EX), .CinEX(Cin_EX), 
                        .mux1_out_EX(Dselect_EX), .sign_ext_EX(sign_ext_EX), .LWID(LW_ID), .LWEX(LW_EX));
    //Set-up mux to output bbus to ALU
    mux32 mux2(.input1(mux2_in_EX), .input2(sign_ext_EX), .ImmID(Imm_EX), .mux_output(bbus));
    //Set-up ALU
    alu32 alu(.d(ALUOutput), .Cout(Cout), .V(V), .a(abus), .b(bbus), .Cin(Cin_EX), .S(S_EX));
    //Set-up EX/MEM D Flip-Flop
    EXMEMDFF EXMEM_DFF(.ALUOutput(ALUOutput), .mux1_out_EX(Dselect_EX), .mux2_in_EX(mux2_in_EX), .SW_EX(SW_EX), .clk(clk), .dbus(daddrbus), .Dselect(Dselect_MEM), 
                       .SW_MEM(SW_MEM), .databus_in(databus_in),.LW_EX(LW_EX), .LW_MEM(LW_MEM));
    //Set-up module for databus
    data_mem databus_mod(.b_oper(databus_in), .databus(databus), .SW_MEM(SW_MEM));
    //Set-up MEM/WB D Flip-Flop
    MEMWBDFF MEMWB_DFF(.daddrbus_in(daddrbus), .databus_in(databus), .Dselect_in(Dselect_MEM), .clk(clk), .SW_in(SW_MEM), .daddrbus_out(mux3_in2), .databus_out(mux3_in1),
                       .Dselect_out(Dselect), .SW_out(SW_WB), .LW_in(LW_MEM), .LW_out(LW_WB));
    //Set-up mux to output to dbus
    mux32 mux3(.input1(mux3_in2), .input2(mux3_in1), .ImmID(LW_WB), .mux_output(dbus));

endmodule