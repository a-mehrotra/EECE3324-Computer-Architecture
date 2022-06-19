`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: cpu5arm_AryanM_tb
// Description: Test bench for ARM LEGV8 CPU
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module cpu5arm_AryanM_tb();
    reg  [31:0] instrbus;
    reg  [31:0] instrbusin[0:209];
    wire [63:0] iaddrbus, daddrbus;
    reg  [63:0] iaddrbusout[0:209], daddrbusout[0:209];
    wire [63:0] databus;
    reg  [63:0] databusk, databusin[0:209], databusout[0:209];
    reg         clk, reset;
    reg         clkd;
    
    reg [63:0] dontcare, activez;
    reg [24*8:1] iname[0:209];
    integer error, k, ntests;
    
    //R-Format
    parameter ADD   = 11'b00101000000;
    parameter ADDS  = 11'b00101000001;
    parameter AND   = 11'b00101000010;
    parameter ANDS  = 11'b00101000011;
    parameter EOR   = 11'b00101000100;
    parameter ENOR  = 11'b00101000101;
    parameter LSL   = 11'b00101000110;
    parameter LSR   = 11'b00101000111;
    parameter ORR   = 11'b00101001000;
    parameter SUB   = 11'b00101001001;
    parameter SUBS  = 11'b00101001010;
    //I-Format
    parameter ADDI  = 10'b1000100000;
    parameter ADDIS = 10'b1000100000;
    parameter ANDI  = 10'b1000100010;
    parameter ANDIS = 10'b1000100011;
    parameter EORI  = 10'b1000100100;
    parameter ENORI = 10'b1000100101;
    parameter ORRI  = 10'b1000100110;
    parameter SUBI  = 10'b1000100111;
    parameter SUBIS = 10'b1000101000;
    //D-Format
    parameter LDUR  = 11'b11010000000;
    parameter STUR  = 11'b11010000001;
    //IM-Format
    parameter MOVZ  = 9'b110010101;
    //B-Format
    parameter B     = 6'b000011;
    //CB-Format
    parameter CBZ   = 8'b11110100;
    parameter CBNZ  = 8'b11110101;
    parameter BEQ   = 8'b01110100;
    parameter BNE   = 8'b01110101;
    parameter BLT   = 8'b01110110;
    parameter BGE   = 8'b01110111;
    
    // Registers
    parameter X0    = 5'b00000;
    parameter X1    = 5'b00001;
    parameter X2    = 5'b00010;
    parameter X3    = 5'b00011;
    parameter X4    = 5'b00100;
    parameter X5    = 5'b00101;
    parameter X6    = 5'b00110;
    parameter X7    = 5'b00111;
    parameter X8    = 5'b01000;
    parameter X9    = 5'b01001;
    parameter X10   = 5'b01010;
    parameter X11   = 5'b01011;
    parameter X12   = 5'b01100;
    parameter X13   = 5'b01101;
    parameter X14   = 5'b01110;
    parameter X15   = 5'b01111;
    parameter X16   = 5'b10000;
    parameter X17   = 5'b10001;
    parameter X18   = 5'b10010;
    parameter X19   = 5'b10011;
    parameter X20   = 5'b10100;
    parameter X21   = 5'b10101;
    parameter X22   = 5'b10110;
    parameter X23   = 5'b10111;
    parameter X24   = 5'b11000;
    parameter X25   = 5'b11001;
    parameter X26   = 5'b11010;
    parameter X27   = 5'b11011;
    parameter X28   = 5'b11100;
    parameter X29   = 5'b11101;
    parameter X30   = 5'b11110;
    parameter XZR   = 5'b11111;
    
    cpu5arm dut(.ibus(instrbus), 
                .clk(clk), 
                .reset(reset), 
                .iaddrbus(iaddrbus), 
                .daddrbus(daddrbus), 
                .databus(databus));
        
    initial begin
    // This test file runs the following program.
    iname[0] =  "ADDI   X5, XZR, #-1";
    iname[1] =  "ADDI   X8, XZR, #15";
    iname[2] =  "ADDI   X10, XZR, #20";
    iname[3] =  "LDUR   X11, [X8, #60]";
    iname[4] =  "LDUR   X12, [X10, #20]";
    iname[5] =  "EORI   X13, XZR, A8C";
    iname[6] =  "STUR   X14, [X10, #2A]";
    iname[7] =  "STUR   X15, [X5, #0]";
    iname[8] =  "ADD    X0, X10, X11";
    iname[9] =  "ORR    X1, X5, X8";
    iname[10] = "AND    X2, X11, X12";
    iname[11] = "ORRI   X3, X14, F0F";
    iname[12] = "SUB    X4, X11, X10";
    iname[13] = "SUB    X6, X13, X14";
    iname[14] = "SUB    X9, X0, X10";
    iname[15] = "EOR    X7, X13, X15";
    iname[16] = "ENOR   X16, X3, X2";
    iname[17] = "EOR    X20, X5, X10";
    iname[18] = "ORRI   X19, X14, 902";
    iname[19] = "ORRI   X18, X6, 000";
    iname[20] = "AND    X17, X3, X4";
    iname[21] = "ANDI   X21, X6, 672";
    iname[22] = "ANDI   X22, X7, AAB";
    iname[23] = "ADDI   X23, X13, CDD";
    iname[24] = "SUBI   X30, X12, 010";
    iname[25] = "ADDI   X29, X0, 439";
    iname[26] = "SUBI   X28, X16, C10";
    iname[27] = "EORI   X27, X9, F5B";
    iname[28] = "ENORI  X26, X7, FED";
    iname[29] = "EORI   X25, X20, 9B6";
    iname[30] = "ENORI  X24, X22, 6A2";
    iname[31] = "ADD    X0, X6, X7";
    iname[32] = "ADD    X8, X13, X14";
    iname[33] = "ADD    X9, X29, X16";
    iname[34] = "AND    X1, X20, X23";
    iname[35] = "AND    X2, X15, X18";
    iname[36] = "AND    X4, X24, X27";
    iname[37] = "EOR    X6, X3, X10";
    iname[38] = "EOR    X10, X14, X19";
    iname[39] = "ENOR   X11, X21, X25";
    iname[40] = "ENOR   X12, X20, X27";
    iname[41] = "EOR    X5, X7, X22";
    iname[42] = "ENOR   X13, X23, X30";
    iname[43] = "LSL    X3, X7, #5";
    iname[44] = "LSL    X7, X14, #0";
    iname[45] = "LSL    X14, X17, #2";
    iname[46] = "LSR    X15, X15, #8";
    iname[47] = "LSR    X18, X6, #4";
    iname[48] = "LSL    X16, X4, #7";
    iname[49] = "LSR    X19, X3, #2";
    iname[50] = "LSL    X17, X1, #4";
    iname[51] = "LSR    X20, X9, #0";
    iname[52] = "ORR    X22, X26, X4";
    iname[53] = "ORR    X23, X5, X8";
    iname[54] = "ORR    X24, X9, X10";
    iname[55] = "SUBI   X25, X1, 044";
    iname[56] = "SUBI   X26, X8, FCB";
    iname[57] = "ENORI  X21, X14, #56C";
    iname[58] = "ENORI  X27, X11, #71A";
    iname[59] = "EORI   X28, X0, #BAE";
    iname[60] = "LDUR   X29, [X12, #F4]";
    iname[61] = "LDUR   X30, [X4, #78]";
    iname[62] = "LDUR   X0, [X1, #FA]";
    iname[63] = "STUR   X1, [X2, #7C]";
    iname[64] = "STUR   X2, [X4, #FF]";
    iname[65] = "STUR   X4, [X5, #9D]";
    iname[66] = "ANDI   X5, X7, #87F";
    iname[67] = "ANDI   X3, X19, #3E5";
    iname[68] = "LSR    X6, X7, #1";
    iname[69] = "ADD    X7, X14, X9";
    iname[70] = "SUB    X8, X24, X25";
    iname[71] = "SUB    X9, X13, X18";
    iname[72] = "ENOR   X10, X30, X29";
    iname[73] = "ORR    X11, X30, X29";
    iname[74] = "EORI   X12, X24, #0FF";
    iname[75] = "ENORI  X13, X23, #FF0";
    iname[76] = "ORRI   X14, X18, #100";
    iname[77] = "ORRI   X15, X20, #34B";
    iname[78] = "SUBI   X16, X19, #810";
    iname[79] = "ANDI   X17, X27, #FFF";
    iname[80] = "ADD    X18, X0, X1";
    iname[81] = "ADD    X19, X2, X3";
    iname[82] = "AND    X20, X30, X29";
    iname[83] = "AND    X21, X29, X5";
    iname[84] = "EOR    X22, X7, X8";
    iname[85] = "EOR    X23, X9, X9";
    iname[86] = "ENOR   X24, X10, X15";
    iname[87] = "ENOR   X25, X11, X12";
    iname[88] = "LSL    X26, X6, #2";
    iname[89] = "LSL    X27, X5, #4";
    iname[90] = "LSR    X28, X0, #6";
    iname[91] = "LSR    X29, X2, #10";
    iname[92] = "ORR    X30, X14, X16";
    iname[93] = "ORR    X0, X10, X12";
    iname[94] = "SUB    X1, X16, X17";
    iname[95] = "SUB    X2, X18, X19";
    iname[96] = "ADDI   X3, X9, #0A2";
    iname[97] = "ADDI   X4, X10, #19E";
    iname[98] = "EORI   X5, X11, #908";
    iname[99] = "EORI   X6, X25, #ABE";
    iname[100] = "ENORI X7, X26, #1BC";
    iname[101] = "ENORI X8, X27, #234";
    iname[102] = "ORRI  X9, X28, #FDC";
    iname[103] = "ORRI  X10, X29, #024";
    iname[104] = "SUBI  X11, X30, #BBA";
    iname[105] = "SUBI  X12, X16, #987";
    iname[106] = "LDUR  X13, [X15, #5A]";
    iname[107] = "LDUR  X14, [X2, #FD]";
    iname[108] = "STUR  X15, [X3, #9B]";
    iname[109] = "STUR  X16, [X4, #78]";
    iname[110] = "ANDI  X17, X5, #984";
    iname[111] = "ANDI  X18, X6, #FEE";
    iname[112] = "";
    iname[113] = "";
    iname[114] = "";
    iname[115] = "";
    iname[116] = "";
    iname[117] = "";
    iname[118] = "";
    iname[119] = "";
    iname[120] = "";
    iname[121] = "";
    iname[122] = "";
    iname[123] = "";
    iname[124] = "";
    iname[125] = "";
    iname[126] = "";
    iname[127] = "";
    iname[128] = "";
    iname[129] = "";
    iname[130] = "";
    iname[131] = "";
    iname[132] = "";
    iname[133] = "";
    iname[134] = "";
    iname[135] = "";
    iname[136] = "";
    iname[137] = "";
    iname[138] = "";
    iname[139] = "";
    iname[140] = "";
    iname[141] = "";
    iname[142] = "";
    iname[143] = "";
    iname[144] = "";
    iname[145] = "";
    iname[146] = "";
    iname[147] = "";
    iname[148] = "";
    iname[149] = "";
    iname[150] = "";
    iname[151] = "";
    iname[152] = "";
    iname[153] = "";
    iname[154] = "";
    iname[155] = "";
    iname[156] = "";
    iname[157] = "";
    iname[158] = "";
    iname[159] = "";
    iname[160] = "";
    iname[161] = "";
    iname[162] = "";
    iname[163] = "";
    iname[164] = "";
    iname[165] = "";
    iname[166] = "";
    iname[167] = "";
    iname[168] = "";
    iname[169] = "";
    iname[170] = "";
    iname[171] = "";
    iname[172] = "";
    iname[173] = "";
    iname[174] = "";
    iname[175] = "";
    iname[176] = "";
    iname[177] = "";
    iname[178] = "";
    iname[179] = "";
    iname[180] = "";
    iname[181] = "";
    iname[182] = "";
    iname[183] = "";
    iname[184] = "";
    iname[185] = "";
    iname[186] = "";
    iname[187] = "";
    iname[188] = "";
    iname[189] = "";
    iname[190] = "";
    iname[191] = "";
    iname[192] = "";
    iname[193] = "";
    iname[194] = "";
    iname[195] = "";
    iname[196] = "";
    iname[197] = "";
    iname[198] = "";
    iname[199] = "";
    iname[200] = "";
    iname[201] = "";
    iname[202] = "";
    iname[203] = "";
    iname[204] = "";
    iname[205] = "";
    iname[206] = "";
    iname[207] = "";
    iname[208] = "";
    iname[209] = "";
    
    //* ADDI   X5, XZR, #-1
    iaddrbusout[0] = 64'h0000000000000000;
    //           opcode ALU_imm  Source Dest
    instrbusin[0]={ADDI, 12'hFFF, XZR, X5};
    
    daddrbusout[0] = dontcare;
    databusin[0] = activez;
    databusout[0] = dontcare;
    
    //ADDI   X8, XZR, #15
    iaddrbusout[1] = 64'h0000000000000004;
    //           opcode ALU_imm  Source Dest
    instrbusin[1]={ADDI, 12'h015, XZR, X8};
    
    daddrbusout[1] = dontcare;
    databusin[1] = activez;
    databusout[1] = dontcare;
    
    //ADDI   X10, XZR, #20
    iaddrbusout[2] = 64'h0000000000000008;
    //           opcode ALU_imm  Source Dest
    instrbusin[2]={ADDI, 12'h020, XZR, X10};
    
    daddrbusout[2] = dontcare;
    databusin[2] = activez;
    databusout[2] = dontcare;
    
    //LDUR   X11, [X8, #60]
    iaddrbusout[3] = 64'h000000000000000C;
    //           opcode offset         OP   Source Dest
    instrbusin[3]={LDUR, 9'b001100000, 2'b00, X8, X11};
    
    daddrbusout[3] = 64'hFFFFFFFFFFFFFFFF;
    databusin[3] = 64'h0000000000000015;
    databusout[3] = dontcare;
    
    //LDUR   X12, [X10, #20]
    iaddrbusout[4] = 64'h0000000000000010;
    //           opcode offset     OP   Source Dest
    instrbusin[4]={LDUR, 9'b000100000, 2'b00, X10, X12};
    
    daddrbusout[4] = 64'h0000000000000015;
    databusin[4] = 64'h0000000000000020;
    databusout[4] = dontcare;
    
    //EORI   X13, XZR, A8C
    iaddrbusout[5] = 64'h0000000000000014;
    //           opcode ALU_imm  Source Dest
    instrbusin[5]={EORI, 12'hA8C, XZR, X10};
    
    daddrbusout[5] = 64'h0000000000000020;
    databusin[5] = activez;
    databusout[5] = dontcare;
    
    //STUR   X14, [X10, #2A]
    iaddrbusout[6] = 64'h0000000000000018;
    //           opcode offset     OP   Source Dest
    instrbusin[6]={STUR, 9'b000101010, 2'b00, X10, X14};
    
    daddrbusout[6] = 64'h000000000000004A;
    databusin[6] = activez;
    databusout[6] = 64'hFFFFFFFFFFFFFFFF;
    
    //STUR   X15, [X5, #0]
    iaddrbusout[7] = 64'h000000000000001C;
    //           opcode offset     OP   Source Dest
    instrbusin[7]={STUR, 9'b000000000, 2'b00, X5, X15};
    
    daddrbusout[7] = 64'hFFFFFFFFFFFFFFFF;
    databusin[7] = activez;
    databusout[7] = 64'h0000000000000015;
    
    //ADD    X0, X10, X11
    iaddrbusout[8] = 64'h0000000000000020;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[8] ={ADD, X11, 6'b000000, X10, X0};
    
    daddrbusout[8] = dontcare;
    databusin[8] = activez;
    databusout[8] = dontcare;
    
    //ORR    X1, X5, X8
    iaddrbusout[9] = 64'h0000000000000024;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[9] ={ORR, X8, 6'b000000, X5, X1};
    
    daddrbusout[9] = dontcare;
    databusin[9] = activez;
    databusout[9] = dontcare;
    
    //AND    X2, X11, X12
    iaddrbusout[10] = 64'h0000000000000028;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[10] ={AND, X12, 6'b000000, X2, X11};
    
    daddrbusout[10] = dontcare;
    databusin[10] = activez;
    databusout[10] = dontcare;
    
    //ORRI   X3, X14, F0F
    iaddrbusout[11] = 64'h000000000000002C;
    //           opcode ALU_imm  Source Dest
    instrbusin[11]={ORRI, 12'hF0F, X14, X3};
    
    daddrbusout[11] = dontcare;
    databusin[11] = activez;
    databusout[11] = dontcare;
    
    //SUB    X4, X11, X10
    iaddrbusout[12] = 64'h0000000000000030;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[12] ={SUB, X10, 6'b000000, X12, X4}; 
    
    daddrbusout[12] = dontcare;
    databusin[12] = activez;
    databusout[12] = dontcare;
    
    //SUB    X6, X13, X14
    iaddrbusout[13] = 64'h0000000000000034;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[13] ={SUB, X14, 6'b000000, X13, X6};
    
    daddrbusout[13] = dontcare;
    databusin[13] = activez;
    databusout[13] = dontcare;
    
    //SUB    X9, X0, X10
    iaddrbusout[14] = 64'h0000000000000038;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[14] ={SUB, X10, 6'b000000, X0, X9};
    
    daddrbusout[14] = dontcare;
    databusin[14] = activez;
    databusout[14] = dontcare;
    
    //EOR    X7, X13, X15
    iaddrbusout[15] = 64'h000000000000003C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[15] ={EOR, X15, 6'b000000, X13, X7};
    
    daddrbusout[15] = dontcare;
    databusin[15] = activez;
    databusout[15] = dontcare;
    
    //ENOR   X16, X3, X2
    iaddrbusout[16] = 64'h0000000000000040;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[16] ={ENOR, X2, 6'b000000, X3, X16};
    
    daddrbusout[16] = dontcare;
    databusin[16] = activez;
    databusout[16] = dontcare;
    
    //EOR    X20, X5, X10
    iaddrbusout[17] = 64'h0000000000000044;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[17] ={EOR, X10, 6'b000000, X5, X20};
    
    daddrbusout[17] = dontcare;
    databusin[17] = activez;
    databusout[17] = dontcare;
    
    //ORRI   X19, X14, 902
    iaddrbusout[18] = 64'h0000000000000048;
    //           opcode ALU_imm  Source Dest
    instrbusin[18]={ORRI, 12'h902, X14, X19};
    
    daddrbusout[18] = dontcare;
    databusin[18] = activez;
    databusout[18] = dontcare;
    
    //ORRI   X18, X6, 000
    iaddrbusout[19] = 64'h000000000000004C;
    //           opcode ALU_imm  Source Dest
    instrbusin[19]={ORRI, 12'h000, X6, X18};
    
    daddrbusout[19] = dontcare;
    databusin[19] = activez;
    databusout[19] = dontcare;
    
    //AND    X17, X3, X4
    iaddrbusout[20] = 64'h0000000000000050;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[20] ={AND, X4, 6'b000000, X3, X17};
    
    daddrbusout[20] = dontcare;
    databusin[20] = activez;
    databusout[20] = dontcare;
    
    //ANDI   X21, X6, 672
    iaddrbusout[21] = 64'h0000000000000054;
    //           opcode ALU_imm  Source Dest
    instrbusin[21]={ANDI, 12'h672, X6, X21};
    
    daddrbusout[21] = dontcare;
    databusin[21] = activez;
    databusout[21] = dontcare;
    
    //ANDI   X22, X7, AAB
    iaddrbusout[22] = 64'h0000000000000058;
    //           opcode ALU_imm  Source Dest
    instrbusin[22]={ANDI, 12'hAAB, X7, X22};
    
    daddrbusout[22] = dontcare;
    databusin[22] = activez;
    databusout[22] = dontcare;
    
    //ADDI   X23, X13, CDD
    iaddrbusout[23] = 64'h000000000000005C;
    //           opcode ALU_imm  Source Dest
    instrbusin[23]={ADDI, 12'hCDD, X13, X23};
    
    daddrbusout[23] = dontcare;
    databusin[23] = activez;
    databusout[23] = dontcare;
    
    //SUBI   X30, X12, 010
    iaddrbusout[24] = 64'h0000000000000060;
    //           opcode ALU_imm  Source Dest
    instrbusin[24]={SUBI, 12'h010, X12, X30};
    
    daddrbusout[24] = dontcare;
    databusin[24] = activez;
    databusout[24] = dontcare;
    
    //ADDI   X29, X0, 439
    iaddrbusout[25] = 64'h0000000000000064;
    //           opcode ALU_imm  Source Dest
    instrbusin[25]={ADDI, 12'h439, X0, X29};
    
    daddrbusout[25] = dontcare;
    databusin[25] = activez;
    databusout[25] = dontcare;
    
    //SUBI   X28, X16, C10
    iaddrbusout[26] = 64'h0000000000000068;
    //           opcode ALU_imm  Source Dest
    instrbusin[26]={SUBI, 12'hC10, X16, X28};
    
    daddrbusout[26] = dontcare;
    databusin[26] = activez;
    databusout[26] = dontcare;
    
    //EORI   X27, X9, F5B
    iaddrbusout[27] = 64'h000000000000006C;
    //           opcode ALU_imm  Source Dest
    instrbusin[27]={EORI, 12'hF5B, X9, X27};
    
    daddrbusout[27] = dontcare;
    databusin[27] = activez;
    databusout[27] = dontcare;
    
    //ENORI  X26, X7, FED
    iaddrbusout[28] = 64'h0000000000000070;
    //           opcode ALU_imm  Source Dest
    instrbusin[28]={ENORI, 12'hFED, X7, X26};
    
    daddrbusout[28] = dontcare;
    databusin[28] = activez;
    databusout[28] = dontcare;
    
    //EORI   X25, X20, 9B6
    iaddrbusout[29] = 64'h0000000000000074;
    //           opcode ALU_imm  Source Dest
    instrbusin[29]={EORI, 12'h9B6, X20, X25};
    
    daddrbusout[29] = dontcare;
    databusin[29] = activez;
    databusout[29] = dontcare;
    
    //ENORI  X24, X22, 6A2
    iaddrbusout[30] = 64'h0000000000000078;
    //           opcode ALU_imm  Source Dest
    instrbusin[30]={ENORI, 12'h6A2, X22, X24};
    
    daddrbusout[30] = dontcare;
    databusin[30] = activez;
    databusout[30] = dontcare;
    
    //ADD    X0, X6, X7
    iaddrbusout[31] = 64'h000000000000007C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[31] ={ADD, X7, 6'b000000, X6, X0};
    
    daddrbusout[31] = dontcare;
    databusin[31] = activez;
    databusout[31] = dontcare;
    
    //ADD    X8, X13, X14
    iaddrbusout[32] = 64'h0000000000000080;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[32] ={ADD, X14, 6'b000000, X13, X8};
    
    daddrbusout[32] = dontcare;
    databusin[32] = activez;
    databusout[32] = dontcare;
    
    //ADD    X9, X29, X16
    iaddrbusout[33] = 64'h0000000000000084;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[33] ={ADD, X16, 6'b000000, X29, X9};
    
    daddrbusout[33] = dontcare;
    databusin[33] = activez;
    databusout[33] = dontcare;
    
    //AND    X1, X20, X23
    iaddrbusout[34] = 64'h0000000000000088;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[34] ={AND, X23, 6'b000000, X20, X1};
    
    daddrbusout[34] = dontcare;
    databusin[34] = activez;
    databusout[34] = dontcare;
    
    //AND    X2, X15, X18
    iaddrbusout[35] = 64'h000000000000008C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[35] ={AND, X18, 6'b000000, X15, X2};
    
    daddrbusout[35] = dontcare;
    databusin[35] = activez;
    databusout[35] = dontcare;
    
    //AND    X4, X24, X27
    iaddrbusout[36] = 64'h0000000000000090;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[36] ={AND, X27, 6'b000000, X24, X4};
    
    daddrbusout[36] = dontcare;
    databusin[36] = activez;
    databusout[36] = dontcare;
    
    //EOR    X6, X3, X10
    iaddrbusout[37] = 64'h0000000000000094;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[37] ={EOR, X10, 6'b000000, X3, X6};
    
    daddrbusout[37] = dontcare;
    databusin[37] = activez;
    databusout[37] = dontcare;
    
    //EOR    X10, X14, X19
    iaddrbusout[38] = 64'h0000000000000098;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[38] ={EOR, X19, 6'b000000, X14, X10};
    
    daddrbusout[38] = dontcare;
    databusin[38] = activez;
    databusout[38] = dontcare;
    
    //ENOR   X11, X21, X25
    iaddrbusout[39] = 64'h000000000000009C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[39] ={ENOR, X25, 6'b000000, X21, X11};
    
    daddrbusout[39] = dontcare;
    databusin[39] = activez;
    databusout[39] = dontcare;
    
    //ENOR   X12, X20, X27
    iaddrbusout[40] = 64'h00000000000000A0;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[40] ={ENOR, X27, 6'b000000, X20, X12};
    
    daddrbusout[40] = dontcare;
    databusin[40] = activez;
    databusout[40] = dontcare;
    
    //EOR    X5, X7, X22
    iaddrbusout[41] = 64'h00000000000000A4;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[41] ={EOR, X22, 6'b000000, X7, X5};
    
    daddrbusout[41] = dontcare;
    databusin[41] = activez;
    databusout[41] = dontcare;
    
    //ENOR   X13, X23, X30
    iaddrbusout[42] = 64'h00000000000000A8;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[42] ={ENOR, X30, 6'b000000, X23, X13};
    
    daddrbusout[42] = dontcare;
    databusin[42] = activez;
    databusout[42] = dontcare;
    
    //LSL    X3, X7, #5
    iaddrbusout[43] = 64'h00000000000000AC;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[43] ={LSL, XZR, 6'b000101, X7, X3};
    
    daddrbusout[43] = dontcare;
    databusin[43] = activez;
    databusout[43] = dontcare;
    
    //LSL    X7, X14, #0
    iaddrbusout[44] = 64'h00000000000000B0;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[44] ={LSL, XZR, 6'b000000, X14, X7};
    
    daddrbusout[44] = dontcare;
    databusin[44] = activez;
    databusout[44] = dontcare;
    
    //LSL    X14, X17, #2
    iaddrbusout[45] = 64'h00000000000000B4;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[45] ={LSL, XZR, 6'b000010, X17, X14};
    
    daddrbusout[45] = dontcare;
    databusin[45] = activez;
    databusout[45] = dontcare;
    
    //LSR    X15, X15, #8
    iaddrbusout[46] = 64'h00000000000000B8;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[8] ={LSR, XZR, 6'b001000, X15, X15};
    
    daddrbusout[46] = dontcare;
    databusin[46] = activez;
    databusout[46] = dontcare;
    
    //LSR    X18, X6, #4
    iaddrbusout[47] = 64'h00000000000000BC;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[47] ={LSR, XZR, 6'b000100, X6, X18};
    
    daddrbusout[47] = dontcare;
    databusin[47] = activez;
    databusout[47] = dontcare;
    
    //LSL    X16, X4, #7
    iaddrbusout[48] = 64'h00000000000000C0;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[48] ={LSL, XZR, 6'b000111, X4, X16};
    
    daddrbusout[48] = dontcare;
    databusin[48] = activez;
    databusout[48] = dontcare;
    
    //LSR    X19, X3, #2
    iaddrbusout[49] = 64'h00000000000000C4;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[49] ={LSR, XZR, 6'b000010, X3, X19};
    
    daddrbusout[49] = dontcare;
    databusin[49] = activez;
    databusout[49] = dontcare;
    
    //LSL    X17, X1, #4
    iaddrbusout[50] = 64'h00000000000000C8;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[50] ={LSL, XZR, 6'b000100, X1, X17};
    
    daddrbusout[50] = dontcare;
    databusin[50] = activez;
    databusout[50] = dontcare;
    
    //LSR    X20, X9, #0
    iaddrbusout[51] = 64'h00000000000000CC;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[51] ={LSR, XZR, 6'b000000, X9, X20};
    
    daddrbusout[51] = dontcare;
    databusin[51] = activez;
    databusout[51] = dontcare;
    
    //ORR    X22, X26, X4
    iaddrbusout[52] = 64'h00000000000000D0;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[52] ={ORR, X4, 6'b000000, X26, X22};
    
    daddrbusout[52] = dontcare;
    databusin[52] = activez;
    databusout[52] = dontcare;
    
    //ORR    X23, X5, X8
    iaddrbusout[53] = 64'h00000000000000D4;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[53] ={ORR, X8, 6'b000000, X5, X23};
    
    daddrbusout[53] = dontcare;
    databusin[53] = activez;
    databusout[53] = dontcare;
    
    //ORR    X24, X9, X10
    iaddrbusout[54] = 64'h00000000000000D8;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[54] ={ORR, X10, 6'b000000, X9, X24};
    
    daddrbusout[54] = dontcare;
    databusin[54] = activez;
    databusout[54] = dontcare;
    
    //SUBI   X25, X1, 044
    iaddrbusout[55] = 64'h00000000000000DC;
    //           opcode ALU_imm  Source Dest
    instrbusin[55]={SUBI, 12'h044, X1, X25};
    
    daddrbusout[55] = dontcare;
    databusin[55] = activez;
    databusout[55] = dontcare;
    
    //SUBI   X26, X8, FCB
    iaddrbusout[56] = 64'h00000000000000E0;
    //           opcode ALU_imm  Source Dest
    instrbusin[56]={SUBI, 12'hFCB, X8, X26};
    
    daddrbusout[56] = dontcare;
    databusin[56] = activez;
    databusout[56] = dontcare;
    
    //ENORI  X21, X14, #56C
    iaddrbusout[57] = 64'h00000000000000E4;
    //           opcode ALU_imm  Source Dest
    instrbusin[57]={ENORI, 12'h56C, X14, X21};
    
    daddrbusout[57] = dontcare;
    databusin[57] = activez;
    databusout[57] = dontcare;
    
    //ENORI  X27, X11, #71A
    iaddrbusout[58] = 64'h00000000000000E8;
    //           opcode ALU_imm  Source Dest
    instrbusin[58]={ENORI, 12'h71A, X11, X27};
    
    daddrbusout[58] = dontcare;
    databusin[58] = activez;
    databusout[58] = dontcare;
    
    //EORI   X28, X0, #BAE
    iaddrbusout[59] = 64'h00000000000000EC;
    //           opcode ALU_imm  Source Dest
    instrbusin[59]={EORI, 12'hBAE, X0, X28};
    
    daddrbusout[59] = dontcare;
    databusin[59] = activez;
    databusout[59] = dontcare;
    
    //LDUR   X29, [X12, #F4]
    iaddrbusout[60] = 64'h00000000000000F0;
    //           opcode offset         OP   Source Dest
    instrbusin[60]={LDUR, 9'b011110100, 2'b00, X12, X29};
    
    daddrbusout[60] = dontcare;
    databusin[60] = activez;
    databusout[60] = dontcare;
    
    //LDUR   X30, [X4, #78]
    iaddrbusout[61] = 64'h00000000000000F4;
    //           opcode offset         OP   Source Dest
    instrbusin[61]={LDUR, 9'b001111000, 2'b00, X4, X30};
    
    daddrbusout[61] = dontcare;
    databusin[61] = activez;
    databusout[61] = dontcare;
    
    //LDUR   X0, [X1, #FA]
    iaddrbusout[62] = 64'h00000000000000F8;
    //           opcode offset         OP   Source Dest
    instrbusin[62]={LDUR, 9'b011111010, 2'b00, X1, X0};
    
    daddrbusout[62] = dontcare;
    databusin[62] = activez;
    databusout[62] = dontcare;
    
    //STUR   X1, [X2, #7C]
    iaddrbusout[63] = 64'h00000000000000FC;
    //           opcode offset         OP   Source Dest
    instrbusin[63]={STUR, 9'b001111100, 2'b00, X2, X1};
    
    daddrbusout[63] = dontcare;
    databusin[63] = activez;
    databusout[63] = dontcare;
    
    //STUR   X2, [X4, #FF]
    iaddrbusout[64] = 64'h0000000000000100;
    //           opcode offset         OP   Source Dest
    instrbusin[64]={STUR, 9'b011111111, 2'b00, X4, X2};
    
    daddrbusout[64] = dontcare;
    databusin[64] = activez;
    databusout[64] = dontcare;
    
    //STUR   X4, [X5, #9D]
    iaddrbusout[65] = 64'h0000000000000104;
    //           opcode offset         OP   Source Dest
    instrbusin[65]={STUR, 9'b010011101, 2'b00, X5, X4};
    
    daddrbusout[65] = dontcare;
    databusin[65] = activez;
    databusout[65] = dontcare;
    
    //ANDI   X5, X7, #87F
    iaddrbusout[66] = 64'h0000000000000108;
    //           opcode ALU_imm  Source Dest
    instrbusin[66]={ANDI, 12'h87F, X7, X5};
    
    daddrbusout[66] = dontcare;
    databusin[66] = activez;
    databusout[66] = dontcare;
    
    //ANDI   X3, X19, #3E5
    iaddrbusout[67] = 64'h000000000000010C;
    //           opcode ALU_imm  Source Dest
    instrbusin[67]={ANDI, 12'h3E5, X19, X3};
    
    daddrbusout[67] = dontcare;
    databusin[67] = activez;
    databusout[67] = dontcare;
    
    //LSR    X6, X7, #1
    iaddrbusout[68] = 64'h0000000000000110;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[68] ={LSR, XZR, 6'b000001, X7, X6};
    
    daddrbusout[68] = dontcare;
    databusin[68] = activez;
    databusout[68] = dontcare;
    
    //ADD    X7, X14, X9
    iaddrbusout[69] = 64'h0000000000000114;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[69] ={ADD, X9, 6'b000000, X14, X7};
    
    daddrbusout[69] = dontcare;
    databusin[69] = activez;
    databusout[69] = dontcare;
    
    //SUB    X8, X24, X25
    iaddrbusout[70] = 64'h0000000000000118;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[70] ={SUB, X25, 6'b000000, X24, X8};
    
    daddrbusout[70] = dontcare;
    databusin[70] = activez;
    databusout[70] = dontcare;
    
    //SUB    X9, X13, X18
    iaddrbusout[71] = 64'h000000000000011C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[70] ={SUB, X18, 6'b000000, X13, X9};
    
    daddrbusout[71] = dontcare;
    databusin[71] = activez;
    databusout[71] = dontcare;
    
    //ENOR   X10, X30, X29
    iaddrbusout[72] = 64'h0000000000000120;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[72] ={ENOR, X29, 6'b000000, X30, X10};
    
    daddrbusout[72] = dontcare;
    databusin[72] = activez;
    databusout[72] = dontcare;
    
    //ORR    X11, X30, X29
    iaddrbusout[73] = 64'h0000000000000124;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[73] ={ORR, X29, 6'b000000, X30, X11};
    
    daddrbusout[73] = dontcare;
    databusin[73] = activez;
    databusout[73] = dontcare;
    
    //EORI   X12, X24, #0FF
    iaddrbusout[74] = 64'h0000000000000128;
    //           opcode ALU_imm  Source Dest
    instrbusin[74]={EORI, 12'h0FF, X24, X12};
    
    daddrbusout[74] = dontcare;
    databusin[74] = activez;
    databusout[74] = dontcare;
    
    //ENORI  X13, X23, #FF0
    iaddrbusout[75] = 64'h000000000000012C;
    //           opcode ALU_imm  Source Dest
    instrbusin[75]={ENORI, 12'hFF0, X23, X13};
    
    daddrbusout[75] = dontcare;
    databusin[75] = activez;
    databusout[75] = dontcare;
    
    //ORRI   X14, X18, #100
    iaddrbusout[76] = 64'h0000000000000130;
    //           opcode ALU_imm  Source Dest
    instrbusin[76]={ORRI, 12'h100, X18, X14};
    
    daddrbusout[76] = dontcare;
    databusin[76] = activez;
    databusout[76] = dontcare;
    
    //ORRI   X15, X20, #34B
    iaddrbusout[77] = 64'h0000000000000134;
    //           opcode ALU_imm  Source Dest
    instrbusin[77]={ORRI, 12'h34E, X20, X15};
    
    daddrbusout[77] = dontcare;
    databusin[77] = activez;
    databusout[77] = dontcare;
    
    //SUBI   X16, X19, #810
    iaddrbusout[78] = 64'h0000000000000138;
    //           opcode ALU_imm  Source Dest
    instrbusin[78]={SUBI, 12'h810, X19, X16};
   
    daddrbusout[78] = dontcare;
    databusin[78] = activez;
    databusout[78] = dontcare;
    
    //ANDI   X17, X27, #FFF
    iaddrbusout[79] = 64'h000000000000013C;
    //           opcode ALU_imm  Source Dest
    instrbusin[79]={ANDI, 12'hFFF, X27, X17};
    
    daddrbusout[79] = dontcare;
    databusin[79] = activez;
    databusout[79] = dontcare;
    
    //ADD    X18, X0, X1
    iaddrbusout[80] = 64'h0000000000000140;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[80] ={ADD, X1, 6'b000000, X0, X18};
    
    daddrbusout[80] = dontcare;
    databusin[80] = activez;
    databusout[80] = dontcare;
    
    //ADD    X19, X2, X3
    iaddrbusout[81] = 64'h0000000000000144;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[81] ={ADD, X3, 6'b000000, X2, X19};
    
    daddrbusout[81] = dontcare;
    databusin[81] = activez;
    databusout[81] = dontcare;
    
    //AND    X20, X30, X29
    iaddrbusout[82] = 64'h0000000000000148;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[82] ={AND, X29, 6'b000000, X30, X20};
    
    daddrbusout[82] = dontcare;
    databusin[82] = activez;
    databusout[82] = dontcare;
    
    //AND    X21, X29, X5
    iaddrbusout[83] = 64'h000000000000014C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[83] ={AND, X5, 6'b000000, X29, X21};
    
    daddrbusout[83] = dontcare;
    databusin[83] = activez;
    databusout[83] = dontcare;
    
    //EOR    X22, X7, X8
    iaddrbusout[84] = 64'h0000000000000150;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[84] ={EOR, X8, 6'b000000, X7, X22};
    
    daddrbusout[84] = dontcare;
    databusin[84] = activez;
    databusout[84] = dontcare;
    
    //EOR    X23, X9, X9
    iaddrbusout[85] = 64'h0000000000000154;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[85] ={EOR, X9, 6'b000000, X9, X23};
    
    daddrbusout[85] = dontcare;
    databusin[85] = activez;
    databusout[85] = dontcare;
    
    //ENOR   X24, X10, X15
    iaddrbusout[86] = 64'h0000000000000158;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[86] ={ENOR, X15, 6'b000000, X10, X24};
    
    daddrbusout[86] = dontcare;
    databusin[86] = activez;
    databusout[86] = dontcare;
    
    //ENOR   X25, X11, X12
    iaddrbusout[87] = 64'h000000000000015C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[87] ={ENOR, X12, 6'b000000, X11, X25};
    
    daddrbusout[87] = dontcare;
    databusin[87] = activez;
    databusout[87] = dontcare;
    
    //LSL    X26, X6, #2
    iaddrbusout[88] = 64'h0000000000000160;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[88] ={LSL, XZR, 6'b000010, X6, X26};
    
    daddrbusout[88] = dontcare;
    databusin[88] = activez;
    databusout[88] = dontcare;
    
    //LSL    X27, X5, #4
    iaddrbusout[89] = 64'h0000000000000164;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[89] ={LSL, XZR, 6'b000100, X5, X27};
    
    daddrbusout[89] = dontcare;
    databusin[89] = activez;
    databusout[89] = dontcare;
    
    //LSR    X28, X0, #6
    iaddrbusout[90] = 64'h0000000000000168;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[90] ={LSR, XZR, 6'b000110, X0, X28};
    
    daddrbusout[90] = dontcare;
    databusin[90] = activez;
    databusout[90] = dontcare;
    
    //LSR    X29, X2, #10
    iaddrbusout[91] = 64'h000000000000016C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[91] ={LSR, XZR, 6'b001010, X2, X29};
    
    daddrbusout[91] = dontcare;
    databusin[91] = activez;
    databusout[91] = dontcare;
    
    //ORR    X30, X14, X16
    iaddrbusout[92] = 64'h0000000000000170;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[92] ={ORR, X16, 6'b000000, X14, X30};
    
    daddrbusout[92] = dontcare;
    databusin[92] = activez;
    databusout[92] = dontcare;
    
    //ORR    X0, X10, X12
    iaddrbusout[93] = 64'h0000000000000174;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[93] ={ORR, X12, 6'b000000, X10, X0};
    
    daddrbusout[93] = dontcare;
    databusin[93] = activez;
    databusout[93] = dontcare;
    
    //SUB    X1, X16, X17
    iaddrbusout[94] = 64'h0000000000000178;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[94] ={SUB, X17, 6'b000000, X16, X1};
    
    daddrbusout[94] = dontcare;
    databusin[94] = activez;
    databusout[94] = dontcare;
    
    //SUB    X2, X18, X19
    iaddrbusout[95] = 64'h000000000000017C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[95] ={SUB, X19, 6'b000000, X18, X2};
    
    daddrbusout[95] = dontcare;
    databusin[95] = activez;
    databusout[95] = dontcare;
    
    //ADDI   X3, X9, #0A2
    iaddrbusout[96] = 64'h0000000000000180;
    //           opcode ALU_imm  Source Dest
    instrbusin[96]={ADDI, 12'h0A2, X9, X3};
    
    daddrbusout[96] = dontcare;
    databusin[96] = activez;
    databusout[96] = dontcare;
    
    //ADDI   X4, X10, #19E
    iaddrbusout[97] = 64'h0000000000000184;
    //           opcode ALU_imm  Source Dest
    instrbusin[97]={ADDI, 12'h19E, X10, X4};
    
    daddrbusout[97] = dontcare;
    databusin[97] = activez;
    databusout[97] = dontcare;
    
    //EORI   X5, X11, #908
    iaddrbusout[98] = 64'h0000000000000188;
    //           opcode ALU_imm  Source Dest
    instrbusin[98]={EORI, 12'h908, X11, X5};
    
    daddrbusout[98] = dontcare;
    databusin[98] = activez;
    databusout[98] = dontcare;
    
    //EORI   X6, X25, #ABE
    iaddrbusout[99] = 64'h000000000000018C;
    //           opcode ALU_imm  Source Dest
    instrbusin[99]={EORI, 12'hABE, X25, X6};
    
    daddrbusout[99] = dontcare;
    databusin[99] = activez;
    databusout[99] = dontcare;
    
    //ENORI X7, X26, #1BC
    iaddrbusout[100] = 64'h0000000000000190;
    //           opcode ALU_imm  Source Dest
    instrbusin[100]={ENORI, 12'h1BC, X26, X7};
    
    daddrbusout[100] = dontcare;
    databusin[100] = activez;
    databusout[100] = dontcare;
    
    //ENORI X8, X27, #234
    iaddrbusout[101] = 64'h0000000000000194;
    //           opcode ALU_imm  Source Dest
    instrbusin[101]={ENORI, 12'h234, X27, X8};
    
    daddrbusout[101] = dontcare;
    databusin[101] = activez;
    databusout[101] = dontcare;
    
    //ORRI  X9, X28, #FDC
    iaddrbusout[102] = 64'h0000000000000198;
    //           opcode ALU_imm  Source Dest
    instrbusin[102]={ORRI, 12'hFDC, X28, X9};
    
    daddrbusout[102] = dontcare;
    databusin[102] = activez;
    databusout[102] = dontcare;
    
    //ORRI  X10, X29, #024
    iaddrbusout[103] = 64'h000000000000019C;
    //           opcode ALU_imm  Source Dest
    instrbusin[103]={ORRI, 12'h024, X29, X10};
    
    daddrbusout[103] = dontcare;
    databusin[103] = activez;
    databusout[103] = dontcare;
    
    //SUBI  X11, X30, #BBA
    iaddrbusout[104] = 64'h00000000000001A0;
    //           opcode ALU_imm  Source Dest
    instrbusin[104]={SUBI, 12'hBBA, X30, X11};
    
    daddrbusout[104] = dontcare;
    databusin[104] = activez;
    databusout[104] = dontcare;
    
    //SUBI  X12, X16, #987
    iaddrbusout[105] = 64'h00000000000001A4;
    //           opcode ALU_imm  Source Dest
    instrbusin[105]={SUBI, 12'h987, X16, X12};
    
    daddrbusout[105] = dontcare;
    databusin[105] = activez;
    databusout[105] = dontcare;
    
    //LDUR  X13, [X15, #5A]
    iaddrbusout[106] = 64'h00000000000001A8;
    //           opcode offset         OP   Source Dest
    instrbusin[106]={LDUR, 9'b001011010, 2'b00, X15, X13};
    
    daddrbusout[106] = dontcare;
    databusin[106] = activez;
    databusout[106] = dontcare;
    
    //LDUR  X14, [X2, #FD]
    iaddrbusout[107] = 64'h00000000000001AC;
    //           opcode offset         OP   Source Dest
    instrbusin[65]={LDUR, 9'b011111101, 2'b00, X2, X14};
    
    daddrbusout[107] = dontcare;
    databusin[107] = activez;
    databusout[107] = dontcare;
    
    //STUR  X15, [X3, #9B]
    iaddrbusout[108] = 64'h00000000000001B0;
    //           opcode offset         OP   Source Dest
    instrbusin[108]={STUR, 9'b010011011, 2'b00, X3, X15};
    
    daddrbusout[108] = dontcare;
    databusin[108] = activez;
    databusout[108] = dontcare;
    
    //STUR  X16, [X4, #78]
    iaddrbusout[109] = 64'h00000000000001B4;
    //           opcode offset         OP   Source Dest
    instrbusin[109]={STUR, 9'b001111000, 2'b00, X4, X16};
    
    daddrbusout[109] = dontcare;
    databusin[109] = activez;
    databusout[109] = dontcare;
    
    //ANDI  X17, X5, #984
    iaddrbusout[110] = 64'h00000000000001B8;
    //           opcode ALU_imm  Source Dest
    instrbusin[110]={ANDI, 12'h984, X5, X17};
    
    daddrbusout[110] = dontcare;
    databusin[110] = activez;
    databusout[110] = dontcare;
    
    //ANDI  X18, X6, #FEE
    iaddrbusout[111] = 64'h00000000000001BC;
    //           opcode ALU_imm  Source Dest
    instrbusin[111]={ANDI, 12'hFEE, X6, X18};
    
    daddrbusout[111] = dontcare;
    databusin[111] = activez;
    databusout[111] = dontcare;
    
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    
    
    
    
    
    dontcare = 64'hx;
    activez = 64'hz;
    
    //ntests = ;

    $timeformat(-9,1,"ns",12);
    
    end
    
    //assumes positive edge FF.
    //testbench reads databus when clk high, writes databus when clk low.
    assign databus = clkd ? 64'bz : databusk;
    
    //Change inputs in middle of period (falling edge).
    initial begin
      error = 0;
      clkd =1;
      clk=1;
      $display ("Time=%t\n  clk=%b", $realtime, clk);
      databusk = 64'bz;
    
      //extended reset to set up PC MUX
      reset = 1;
      $display ("reset=%b", reset);
      #5
      clk=0;
      clkd=0;
      $display ("Time=%t\n  clk=%b", $realtime, clk);
      #5
    
      clk=1;
      clkd=1;
      $display ("Time=%t\n  clk=%b", $realtime, clk);
      #5
      clk=0;
      clkd=0;
      $display ("Time=%t\n  clk=%b", $realtime, clk);
      #5
      $display ("Time=%t\n  clk=%b", $realtime, clk);
    
    for (k=0; k<= 209; k=k+1) begin
        clk=1;
        $display ("Time=%t\n  clk=%b", $realtime, clk);
        #2
        clkd=1;
        #3
        $display ("Time=%t\n  clk=%b", $realtime, clk);
        reset = 0;
        $display ("reset=%b", reset);
    
    
        //set load data for 3rd previous instruction
        if (k >=3)
          databusk = databusin[k-3];
    
        //check PC for this instruction
        if (k >= 0) begin
          $display ("  Testing PC for instruction %d", k);
          $display ("    Your iaddrbus =    %b", iaddrbus);
          $display ("    Correct iaddrbus = %b", iaddrbusout[k]);
          if (iaddrbusout[k] !== iaddrbus) begin
            $display ("    -------------ERROR. A Mismatch Has Occured-----------");
            error = error + 1;
          end
        end
    
        //put next instruction on ibus
        instrbus=instrbusin[k];
        $display ("  instrbus=%b %b %b %b %b for instruction %d: %s", instrbus[31:26], instrbus[25:21], instrbus[20:16], instrbus[15:11], instrbus[10:0], k, iname[k]);
    
        //check data address from 3rd previous instruction
        if ( (k >= 3) && (daddrbusout[k-3] !== dontcare) ) begin
          $display ("  Testing data address for instruction %d:", k-3);
          $display ("  %s", iname[k-3]);
          $display ("    Your daddrbus =    %b", daddrbus);
          $display ("    Correct daddrbus = %b", daddrbusout[k-3]);
          if (daddrbusout[k-3] !== daddrbus) begin
            $display ("    -------------ERROR. A Mismatch Has Occured-----------");
            error = error + 1;
          end
        end
    
        //check store data from 3rd previous instruction
        if ( (k >= 3) && (databusout[k-3] !== dontcare) ) begin
          $display ("  Testing store data for instruction %d:", k-3);
          $display ("  %s", iname[k-3]);
          $display ("    Your databus =    %b", databus);
          $display ("    Correct databus = %b", databusout[k-3]);
          if (databusout[k-3] !== databus) begin
            $display ("    -------------ERROR. A Mismatch Has Occured-----------");
            error = error + 1;
          end
        end
    
        clk = 0;
        $display ("Time=%t\n  clk=%b", $realtime, clk);
        #2
        clkd = 0;
        #3
        $display ("Time=%t\n  clk=%b", $realtime, clk);
      end
    
      if ( error !== 0) begin
        $display("--------- SIMULATION UNSUCCESFUL - MISMATCHES HAVE OCCURED ----------");
        $display(" No. Of Errors = %d", error);
      end
      if ( error == 0)
        $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");
    end
    
endmodule
