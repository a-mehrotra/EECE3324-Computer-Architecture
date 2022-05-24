`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: Controller
// Project Name: Assignment 4
//////////////////////////////////////////////////////////////////////////////////

module controller(ibus, clk, Cin, Imm, S, Aselect, Bselect, Dselect);
    //I/O set-up
    input[31:0] ibus;
    input clk;
    output[2:0] S;
    output Imm, Cin;
    output[31:0] Aselect, Bselect, Dselect;
    
    //Wires for intermediate values
    wire[31:0] decoderInput, rd_muxInput, rt_muxInput, DselectID, DselectEx;
    wire ImmID, CinID;
    wire[2:0] SID;
    
    // D Flip-Flop which takes in ibus and outputs to decoders
    DFF32 IFIDDFF(.DFFInput32(ibus), .DFFOutput32(decoderInput), .clk(clk));
    // Set-up rs decoder and output to Aselect
    rs_decoder rs_decoder(.ibus(decoderInput), .Aselect(Aselect));
    //Set-up rt decoder and output to Bselect and mux
    rt_decoder rt_decoder(.ibus(decoderInput), .Bselect(Bselect));
    //assign Bselect = rt_muxInput; 
    //Set-up rd decoder and output to mux
    rd_decoder rd_decoder(.ibus(decoderInput), .mux_rd(rd_muxInput));
    //Set-up opcode decoder and output to ID/EX DFF
    opcode_decoder opcode_decoder(.ibus(decoderInput), .ImmID(ImmID), .SID(SID), .CinID(CinID));
    // Set-up mux to output Dselect to DFF
    mux32 mux32ID(.rt(Bselect), .rd(rd_muxInput), .ImmID(ImmID), .DselectID(DselectID));
    // Set-up D Flip-Flop from ID to EX
    IDEXDFF32 IdToExDFF(.DselectID(DselectID), .ImmID(ImmID), .SID(SID), .CinID(CinID), .DselectEx(DselectEx), .Imm(Imm), .S(S), .Cin(Cin), .clk(clk));
    // Set-up D Flip-Flop from EX to MEM
    DFF32 ExToMemDFF(.DFFInput32(DselectEx), .DFFOutput32(Dselect), .clk(clk));
    
endmodule
