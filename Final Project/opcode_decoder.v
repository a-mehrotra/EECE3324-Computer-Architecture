`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: opcode_decoder
// Description: Gives the instruction type from the operation code in ibus
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module opcode_decoder(ibus, S_ID, Cin_ID, Imm_ID,
                      SetFlag_ID, SW_ID, LW_ID, r_type,
                      i_type, d_type, b_type, cb_type, iw_type,
                      zcomp, nzcomp, BEQ, BNE, BLT, BGE, shamt_ins);
    //Instantiate inputs and outputs
    input[31:0] ibus;
    output reg [2:0] S_ID;
    output reg Cin_ID, Imm_ID, SetFlag_ID, SW_ID, LW_ID, r_type, i_type, d_type, b_type, cb_type, iw_type,
               zcomp, nzcomp, BEQ, BNE, BLT, BGE, shamt_ins;
               
    wire[10:0] r_code = ibus[31:21];
    wire[9:0] i_code = ibus[31:22];  
    wire[10:0] d_code = ibus[31:21];
    wire[5:0] b_code = ibus[31:26];
    wire[8:0] cb_code = ibus[31:24];
    wire[10:0] iw_code = ibus[31:21];
    
    always@(ibus) begin
        case(r_code)
            //ADD 
            11'b00101000000: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //ADDS 
            11'b00101000001: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b1;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //AND
            11'b00101000010: begin
                S_ID = 3'b110;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0;
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0; 
                shamt_ins = 1'b0;
            end
            //ANDS
            11'b00101000011: begin
                S_ID = 3'b110;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b1;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //EOR
            11'b00101000100: begin
                S_ID = 3'b000;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //ENOR
            11'b00101000101: begin
                S_ID = 3'b001;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //LSL
            11'b00101000110: begin
                S_ID = 3'b101;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b1;
            end
            //LSR
            11'b00101000111: begin
                S_ID = 3'b111;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b1;
            end
            //ORR
            11'b00101001000: begin
                S_ID = 3'b100;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //SUB
            11'b00101001001: begin
                S_ID = 3'b011;
                Cin_ID = 1'b1;
                Imm_ID = 1'b0;
                SetFlag_ID = 1'b0;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0;  
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //SUBS
            11'b00101001010: begin
                S_ID = 3'b011;
                Cin_ID = 1'b1;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b1;
                r_type = 1'b1;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            11'b00000000000: begin
                S_ID = 3'bxxx;
                Cin_ID = 1'bx;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
        endcase
        case(i_code)
            //ADDI
            10'b1000100000: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0;
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0; 
                shamt_ins = 1'b0;
            end
            //ADDIS
            10'b1000100001: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b1;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //ANDI
            10'b1000100010: begin
                S_ID = 3'b110;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //ANDIS
            10'b1000100011: begin
                S_ID = 3'b110;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1;
                SetFlag_ID = 1'b1; 
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //EORI
            10'b1000100100: begin
                S_ID = 3'b000;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //ENORI
            10'b1000100101: begin
                S_ID = 3'b001;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0;
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0; 
                shamt_ins = 1'b0;
            end
            //ORRI
            10'b1000100110: begin
                S_ID = 3'b100;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //SUBI
            10'b1000100111: begin
                S_ID = 3'b011;
                Cin_ID = 1'b1;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //SUBIS
            10'b1000101000: begin
                S_ID = 3'b011;
                Cin_ID = 1'b1;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b1;
                r_type = 1'b0;
                i_type = 1'b1; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            10'b0000000000: begin
                S_ID = 3'bxxx;
                Cin_ID = 1'bx;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
        endcase  
        case(d_code)
            //LDUR
            11'b11010000000: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b1; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b1;
                shamt_ins = 1'b0;
            end
            //STUR
            11'b11010000001: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0;
                SetFlag_ID = 1'b0; 
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b1; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b1;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            11'b00000000000: begin
                S_ID = 3'bxxx;
                Cin_ID = 1'bx;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
        endcase
        case(iw_code)
            //MOVZ
            9'b110010101: begin
                S_ID = 3'b101;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b1; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            9'b000000000: begin
                S_ID = 3'bxxx;
                Cin_ID = 1'bx;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
        endcase
        case(b_code)
            //B
            6'b000011: begin
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b1; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            6'b000000: begin
                S_ID = 3'bxxx;
                Cin_ID = 1'bx;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
        endcase
        case(cb_code)
            //CBZ
            8'b11110100: begin 
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1;
                SetFlag_ID = 1'b0; 
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b1;
                iw_type = 1'b0; 
                zcomp = 1'b1;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //CBNZ
            8'b11110101: begin 
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b1;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b1; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //B.EQ
            8'b01110100: begin  
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b1;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b1; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //B.NE
            8'b01110101: begin 
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b1;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b1; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //B.LT (Signed)
            8'b01110110: begin 
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b1;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b1;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            //B.GE (Signed)
            8'b01110111: begin 
                S_ID = 3'b010;
                Cin_ID = 1'b0;
                Imm_ID = 1'b1; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b1;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b1;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
            8'b00000000: begin
                S_ID = 3'bxxx;
                Cin_ID = 1'bx;
                Imm_ID = 1'b0; 
                SetFlag_ID = 1'b0;
                r_type = 1'b0;
                i_type = 1'b0; 
                d_type = 1'b0; 
                b_type = 1'b0; 
                cb_type = 1'b0;
                iw_type = 1'b0; 
                zcomp = 1'b0;
                nzcomp = 1'b0; 
                BEQ = 1'b0; 
                BNE = 1'b0; 
                BLT = 1'b0;
                BGE = 1'b0;
                SW_ID = 1'b0;
                LW_ID = 1'b0;
                shamt_ins = 1'b0;
            end
        endcase
      
    end 
    
    
endmodule
