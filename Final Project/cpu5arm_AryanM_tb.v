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
    iname[6] =  "STUR   X5, [X10, #2A]";
    iname[7] =  "STUR   X8, [X5, #0]";
    iname[8] =  "ADD    X0, X10, X11";
    iname[9] =  "ORR    X1, X5, X8";
    iname[10] = "AND    X2, X11, X12";
    iname[11] = "ORRI   X3, X13, F0F";
    iname[12] = "SUB    X4, X11, X10";
    iname[13] = "SUB    X6, X12, X0";
    iname[14] = "SUB    X9, X0, X10";
    iname[15] = "EOR    X7, X13, X3";
    iname[16] = "ENOR   X16, X3, X2";
    iname[17] = "EOR    X20, X5, X10";
    iname[18] = "ORRI   X19, X3, 902";
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
    iname[31] = "ADD    X14, X6, X7";
    iname[32] = "ADD    X15, X13, X12";
    iname[33] = "ADD    X9, X29, X16";
    iname[34] = "AND    X1, X20, X23";
    iname[35] = "AND    X2, X4, X18";
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
    iname[47] = "LSR    X18, X6, #0";
    iname[48] = "LSL    X16, X4, #7";
    iname[49] = "LSR    X19, X3, #2";
    iname[50] = "LSL    X17, X1, #4";
    iname[51] = "LSR    X20, X9, #0";
    iname[52] = "ORR    X22, X26, X4";
    iname[53] = "ORR    X23, X5, X8";
    iname[54] = "ORR    X24, X9, X10";
    iname[55] = "SUBI   X25, X1, 044";
    iname[56] = "SUBI   X26, X9, FCB";
    iname[57] = "ENORI  X21, X14, #56C";
    iname[58] = "ENORI  X27, X11, #71A";
    iname[59] = "EORI   X28, X0, #BAE";
    iname[60] = "LDUR   X29, [X12, #F4]";
    iname[61] = "LDUR   X30, [X4, #78]";
    iname[62] = "LDUR   X0, [X1, #FA]";
    iname[63] = "STUR   X1, [X2, #7C]";
    iname[64] = "STUR   X2, [X4, #FF]";
    iname[65] = "STUR   X4, [X5, #9D]";
    iname[66] = "ANDI   X8, X7, #87F";
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
    iname[112] = "ADDS  X0, X21, X20";
    iname[113] = "BEQ   #10";       //Branch not taken
    iname[114] = "NOP";
    iname[115] = "ADD   X1, X23, X23"; 
    iname[116] = "ADDS  X2, X15, X28"; 
    iname[117] = "BLT   #2";        //Branch taken 
    iname[118] = "NOP";
    iname[119] = "NOP"; 
    iname[120] = "NOP";
    iname[121] = "ADDS  X4, X28, X30";
    iname[122] = "BGE #5";          //Branch taken 
    iname[123] = "NOP";
    iname[124] = "NOP";
    iname[125] = "NOP";
    iname[126] = "B #20";           //Branch taken
    iname[127] = "NOP";
    iname[128] = "NOP";
    iname[129] = "NOP";
    iname[130] = "ANDS  X4, X19, X22";
    iname[131] = "BLT   #20";       //Branch not taken
    iname[132] = "NOP";
    iname[133] = "CBZ   X23, #10";  //Branch taken
    iname[134] = "NOP";
    iname[135] = "CBNZ  X27, #15";  //Branch taken
    iname[136] = "NOP";
    iname[137] = "CBNZ  X23, #80";  //Branch not taken
    iname[138] = "NOP";
    iname[139] = "B     #10";       //Branch taken
    iname[140] = "NOP";
    iname[141] = "NOP";
    iname[142] = "SUBS  X5, X20, X21";
    iname[143] = "BNE   #10";       //Branch taken
    iname[144] = "NOP";
    iname[145] = "NOP";
    iname[146] = "NOP";
    iname[147] = "CBZ   X15, #20";  //Branch not taken
    iname[148] = "NOP"; 
    iname[149] = "CBZ   X30, #0";   //Branch not taken
    iname[150] = "NOP";
    iname[151] = "CBNZ  X20, #0";   //Branch taken
    iname[152] = "NOP";
    iname[153] = "NOP";
    iname[154] = "ADDIS X15, X18, #9A";
    iname[155] = "BEQ   #80";       //Branch not taken
    iname[156] = "NOP";
    iname[157] = "SUB   X16, X6, X10";
    iname[158] = "ADDIS X19, X5, #8AC";
    iname[159] = "BLT   #20";       //Branch not taken
    iname[160] = "NOP";
    iname[161] = "ADDI  X20, X8, #09E";
    iname[162] = "ADDIS X21, X12, #FEA";
    iname[163] = "CBZ   X1, #10";   //Branch taken
    iname[164] = "NOP ";
    iname[165] = "NOP ";
    iname[166] = "B     #0";        //Branch taken
    iname[167] = "NOP";
    iname[168] = "CBNZ  X1, #10";   //Branch not taken
    iname[169] = "NOP";
    iname[170] = "ANDIS X22, X6, #ABC";
    iname[171] = "BEQ   #1";        //Branch not taken
    iname[172] = "NOP ";
    iname[173] = "ANDIS X23, X9, #765";
    iname[174] = "BNE   #1";        //Branch taken
    iname[175] = "NOP";
    iname[176] = "NOP";
    iname[177] = "NOP";
    iname[178] = "CBNZ  X1, #12";    //Branch not taken
    iname[179] = "NOP";
    iname[180] = "MOVZ  X23, #3A3";
    iname[181] = "CBZ   X16, #5";    //Branch not taken
    iname[182] = "NOP";
    iname[183] = "MOVZ  X24, #0";
    iname[184] = "SUBIS X25, X13, #AAA";
    iname[185] = "CBNZ  X1, #9";     //Branch not taken
    iname[186] = "NOP";
    iname[187] = "SUBIS X26, X8, #0";
    iname[188] = "SUBIS X27, X3, #EFE";
    iname[189] = "BNE   #14";       //Branch taken
    iname[190] = "NOP";
    iname[191] = "NOP";
    iname[192] = "NOP";
    iname[193] = "MOVZ  X28, #9AE";
    iname[194] = "ADD   X29, X0, X1";
    iname[195] = "AND   X30, X3, X2";
    iname[196] = "SUB   X5, X2, X7";
    iname[197] = "ORR   X0, X10, X11";
    iname[198] = "ANDI  X1, X1, X4";
    iname[199] = "ADDI  X2, X20, #90A";
    iname[200] = "SUBI  X4, X3, #AFF";
    iname[201] = "ORRI  X6, X8, #00A";
    iname[202] = "EOR   X7, X17, X18";
    iname[203] = "EORI  X8, X22, #00C";
    iname[204] = "ADD   X9, X27, X28";
    iname[205] = "SUB   X10, X27, X25";
    iname[206] = "AND   X11, X20, X21";
    iname[207] = "EOR   X12, X26, X15";
    iname[208] = "ORR   X13, X2, X16";
    iname[209] = "ADDI  X14, X28, #E45";
    
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
    databusin[3] = 64'hAAAAAAAAAAAAAAAA;
    databusout[3] = dontcare;
    
    //LDUR   X12, [X10, #20]
    iaddrbusout[4] = 64'h0000000000000010;
    //           opcode offset     OP   Source Dest
    instrbusin[4]={LDUR, 9'b000100000, 2'b00, X10, X12};
    
    daddrbusout[4] = 64'h0000000000000040;
    databusin[4] = 64'hDDDDDDDDDDDDDDDD;
    databusout[4] = dontcare;
    
    //EORI   X13, XZR, A8C
    iaddrbusout[5] = 64'h0000000000000014;
    //           opcode ALU_imm  Source Dest
    instrbusin[5]={EORI, 12'hA8C, XZR, X10};
    
    daddrbusout[5] = 64'h0000000000000020;
    databusin[5] = activez;
    databusout[5] = dontcare;
    
    //STUR   X5, [X10, #2A]
    iaddrbusout[6] = 64'h0000000000000018;
    //           opcode offset     OP   Source Dest
    instrbusin[6]={STUR, 9'b000101010, 2'b00, X10, X5};
    
    daddrbusout[6] = 64'h000000000000004A;
    databusin[6] = activez;
    databusout[6] = 64'hFFFFFFFFFFFFFFFF;
    
    //STUR   X8, [X5, #0]
    iaddrbusout[7] = 64'h000000000000001C;
    //           opcode offset     OP   Source Dest
    instrbusin[7]={STUR, 9'b000000000, 2'b00, X5, X8};
    
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
    
    //ORRI   X3, X13, F0F
    iaddrbusout[11] = 64'h000000000000002C;
    //           opcode ALU_imm  Source Dest
    instrbusin[11]={ORRI, 12'hF0F, X13, X3};
    
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
    
    //SUB    X6, X12, X0
    iaddrbusout[13] = 64'h0000000000000034;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[13] ={SUB, X0, 6'b000000, X12, X6};
    
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
    
    //EOR    X7, X13, X3
    iaddrbusout[15] = 64'h000000000000003C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[15] ={EOR, X3, 6'b000000, X13, X7};
    
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
    
    //ORRI   X19, X3, 902
    iaddrbusout[18] = 64'h0000000000000048;
    //           opcode ALU_imm  Source Dest
    instrbusin[18]={ORRI, 12'h902, X3, X19};
    
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
    
    //ADD    X14, X6, X7
    iaddrbusout[31] = 64'h000000000000007C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[31] ={ADD, X7, 6'b000000, X6, X14};
    
    daddrbusout[31] = dontcare;
    databusin[31] = activez;
    databusout[31] = dontcare;
    
    //ADD    X15, X13, X12
    iaddrbusout[32] = 64'h0000000000000080;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[32] ={ADD, X12, 6'b000000, X13, X15};
    
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
    
    //AND    X2, X4, X18
    iaddrbusout[35] = 64'h000000000000008C;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[35] ={AND, X18, 6'b000000, X4, X2};
    
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
    
    //LSR    X18, X6, #0
    iaddrbusout[47] = 64'h00000000000000BC;
    //             opcode Source2 Shamt Source1 Dest
    instrbusin[47] ={LSR, XZR, 6'b000000, X6, X18};
    
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
    
    //SUBI   X25, X4, 044
    iaddrbusout[55] = 64'h00000000000000DC;
    //           opcode ALU_imm  Source Dest
    instrbusin[55]={SUBI, 12'h044, X4, X25};
    
    daddrbusout[55] = dontcare;
    databusin[55] = activez;
    databusout[55] = dontcare;
    
    //SUBI   X26, X9, FCB
    iaddrbusout[56] = 64'h00000000000000E0;
    //           opcode ALU_imm  Source Dest
    instrbusin[56]={SUBI, 12'hFCB, X9, X26};
    
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
    
    daddrbusout[60] = 64'h00000000AAAAA86F;
    databusin[60] = 64'h0000FFFF0000EEEE;
    databusout[60] = dontcare;
    
    //LDUR   X30, [X4, #78]
    iaddrbusout[61] = 64'h00000000000000F4;
    //           opcode offset         OP   Source Dest
    instrbusin[61]={LDUR, 9'b001111000, 2'b00, X4, X30};
    
    daddrbusout[61] = 64'h00000000000001D2;
    databusin[61] = 64'h000012349ABC5678;
    databusout[61] = dontcare;
    
    //LDUR   X0, [X1, #FA]
    iaddrbusout[62] = 64'h00000000000000F8;
    //           opcode offset         OP   Source Dest
    instrbusin[62]={LDUR, 9'b011111010, 2'b00, X1, X0};
    
    daddrbusout[62] = 64'h00000000000000FA;
    databusin[62] = 64'h000000000000FEDC;
    databusout[62] = dontcare;
    
    //STUR   X1, [X2, #7C]
    iaddrbusout[63] = 64'h00000000000000FC;
    //           opcode offset         OP   Source Dest
    instrbusin[63]={STUR, 9'b001111100, 2'b00, X2, X1};
    
    daddrbusout[63] = 64'h000000002222207C;
    databusin[63] = activez;
    databusout[63] = 64'h0000000000000000;
    
    //STUR   X2, [X4, #FF]
    iaddrbusout[64] = 64'h0000000000000100;
    //           opcode offset         OP   Source Dest
    instrbusin[64]={STUR, 9'b011111111, 2'b00, X4, X2};
    
    daddrbusout[64] = 64'h0000000000000259;
    databusin[64] = activez;
    databusout[64] = 64'h0000000022222000;
    
    //STUR   X4, [X5, #9D]
    iaddrbusout[65] = 64'h0000000000000104;
    //           opcode offset         OP   Source Dest
    instrbusin[65]={STUR, 9'b010011101, 2'b00, X5, X4};
    
    daddrbusout[65] = 64'h000000000000059D;
    databusin[65] = activez;
    databusout[65] = 64'h000000000000015A;
    
    //ANDI   X8, X7, #87F
    iaddrbusout[66] = 64'h0000000000000108;
    //           opcode ALU_imm  Source Dest
    instrbusin[66]={ANDI, 12'h87F, X7, X8};
    
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
    instrbusin[77]={ORRI, 12'h34B, X20, X15};
    
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
    
    daddrbusout[106] = 64'h000000008888B029;
    databusin[106] = 64'h0000444400008888;
    databusout[106] = dontcare;
    
    //LDUR  X14, [X2, #FD]
    iaddrbusout[107] = 64'h00000000000001AC;
    //           opcode offset         OP   Source Dest
    instrbusin[65]={LDUR, 9'b011111101, 2'b00, X2, X14};
    
    daddrbusout[107] = 64'h00000000DDDE2F79;
    databusin[107] = 64'h6666000000002222;
    databusout[107] = dontcare;
    
    //STUR  X15, [X3, #9B]
    iaddrbusout[108] = 64'h00000000000001B0;
    //           opcode offset         OP   Source Dest
    instrbusin[108]={STUR, 9'b010011011, 2'b00, X3, X15};
    
    daddrbusout[108] = 64'h000000000000009B;
    databusin[108] = activez;
    databusout[108] = 64'h000000008888AFCF;
    
    //STUR  X16, [X4, #78]
    iaddrbusout[109] = 64'h00000000000001B4;
    //           opcode offset         OP   Source Dest
    instrbusin[109]={STUR, 9'b001111000, 2'b00, X4, X16};
    
    daddrbusout[109] = 64'h0000EDCB9ABC497F;
    databusin[109] = activez;
    databusout[109] = 64'h0000000000002408;
    
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
    
    //ADDS  X0, X21, X20
    iaddrbusout[112] = 64'h00000000000001C0;
    
    daddrbusout[112] = dontcare;
    databusin[112] = activez;
    databusout[112] = dontcare;
    
    //BEQ   #10       //Branch not taken
    iaddrbusout[113] = 64'h00000000000001C4;
    
    daddrbusout[113] = dontcare;
    databusin[113] = activez;
    databusout[113] = dontcare;
    
    //NOP
    iaddrbusout[114] = 64'h00000000000001C8;
    
    instrbusin[114] = 32'b00000000000000000000000000000000;
    
    daddrbusout[114] = dontcare;
    databusin[114] = activez;
    databusout[114] = dontcare;

    //ADD X1, X23, X23
    iaddrbusout[115] = 64'h00000000000001CC;
    
    daddrbusout[115] = dontcare;
    databusin[115] = activez;
    databusout[115] = dontcare;
    
    //ADDS X2, X15, X28
    iaddrbusout[116] = 64'h00000000000001D0;
    
    daddrbusout[116] = dontcare;
    databusin[116] = activez;
    databusout[116] = dontcare;
    
    //BLT #2        //Branch taken
    iaddrbusout[117] = 64'h00000000000001D4;
    
    daddrbusout[117] = dontcare;
    databusin[117] = activez;
    databusout[117] = dontcare;
    
    //NOP
    iaddrbusout[118] = 64'h00000000000001D8;
    
    instrbusin[118] = 32'b00000000000000000000000000000000;
    
    daddrbusout[118] = dontcare;
    databusin[118] = activez;
    databusout[118] = dontcare;
    
    //NOP
    iaddrbusout[119] = 64'h00000000000001DC;
    
    instrbusin[119] = 32'b00000000000000000000000000000000;
    
    daddrbusout[119] = dontcare;
    databusin[119] = activez;
    databusout[119] = dontcare;
    
    //NOP
    iaddrbusout[120] = 64'h00000000000001E0;
    
    instrbusin[120] = 32'b00000000000000000000000000000000;
    
    daddrbusout[120] = dontcare;
    databusin[120] = activez;
    databusout[120] = dontcare;
    
    //ADDS X4, X28, X30
    iaddrbusout[121] = 64'h00000000000001E4;
    
    daddrbusout[121] = dontcare;
    databusin[121] = activez;
    databusout[121] = dontcare;
    
    //BGE #5        //Branch taken
    iaddrbusout[122] = 64'h00000000000001E8;
    
    daddrbusout[122] = dontcare;
    databusin[122] = activez;
    databusout[122] = dontcare;
    
    //NOP
    iaddrbusout[123] = 64'h00000000000001EC;
    
    instrbusin[123] = 32'b00000000000000000000000000000000;
    
    daddrbusout[123] = dontcare;
    databusin[123] = activez;
    databusout[123] = dontcare;
    
    //NOP
    iaddrbusout[124] = 64'h00000000000001FC;
    
    instrbusin[124] = 32'b00000000000000000000000000000000;
    
    daddrbusout[124] = dontcare;
    databusin[124] = activez;
    databusout[124] = dontcare;
    
    //NOP
    iaddrbusout[125] = 64'h0000000000000200;
    
    instrbusin[125] = 32'b00000000000000000000000000000000;
    
    daddrbusout[125] = dontcare;
    databusin[125] = activez;
    databusout[125] = dontcare;
    
    //B #20         //Branch taken
    iaddrbusout[126] = 64'h0000000000000204;
    
    daddrbusout[126] = dontcare;
    databusin[126] = activez;
    databusout[126] = dontcare;
    
    //NOP
    iaddrbusout[127] = 64'h0000000000000208;
    
    instrbusin[127] = 32'b00000000000000000000000000000000;
    
    daddrbusout[127] = dontcare;
    databusin[127] = activez;
    databusout[127] = dontcare;
    
    //NOP
    iaddrbusout[128] = 64'h0000000000000254;
    
    instrbusin[128] = 32'b00000000000000000000000000000000;
    
    daddrbusout[128] = dontcare;
    databusin[128] = activez;
    databusout[128] = dontcare;
    
    //NOP
    iaddrbusout[129] = 64'h0000000000000258;
    
    instrbusin[129] = 32'b00000000000000000000000000000000;
    
    daddrbusout[129] = dontcare;
    databusin[129] = activez;
    databusout[129] = dontcare;
    
    //ANDS X4, X19, X22
    iaddrbusout[130] = 64'h000000000000025C;
    
    daddrbusout[130] = dontcare;
    databusin[130] = activez;
    databusout[130] = dontcare;
    
    //BLT #20       //Branch not taken
    iaddrbusout[131] = 64'h0000000000000260;
    
    daddrbusout[131] = dontcare;
    databusin[131] = activez;
    databusout[131] = dontcare;
    
    //NOP
    iaddrbusout[132] = 64'h0000000000000264;
    
    instrbusin[132] = 32'b00000000000000000000000000000000;
    
    daddrbusout[132] = dontcare;
    databusin[132] = activez;
    databusout[132] = dontcare;
    
    //CBZ X23, #10          //Branch taken
    iaddrbusout[133] = 64'h0000000000000268;
    
    daddrbusout[133] = dontcare;
    databusin[133] = activez;
    databusout[133] = dontcare;
    
    //NOP
    iaddrbusout[134] = 64'h000000000000026C;
    
    instrbusin[134] = 32'b00000000000000000000000000000000;
    
    daddrbusout[134] = dontcare;
    databusin[134] = activez;
    databusout[134] = dontcare;
    
    //CBNZ X27, #15     //Branch taken
    iaddrbusout[135] = 64'h0000000000000290;
    
    daddrbusout[135] = dontcare;
    databusin[135] = activez;
    databusout[135] = dontcare;
    
    //NOP
    iaddrbusout[136] = 64'h0000000000000294;
    
    instrbusin[136] = 32'b00000000000000000000000000000000;
    
    daddrbusout[136] = dontcare;
    databusin[136] = activez;
    databusout[136] = dontcare;
    
    //CBNZ X23, #80     //Branch not taken
    iaddrbusout[137] = 64'h0000000000000298;
    
    daddrbusout[137] = dontcare;
    databusin[137] = activez;
    databusout[137] = dontcare;
    
    //NOP
    iaddrbusout[138] = 64'h000000000000029C;
    
    instrbusin[138] = 32'b00000000000000000000000000000000;
    
    daddrbusout[138] = dontcare;
    databusin[138] = activez;
    databusout[138] = dontcare;
    
    //B     #10         //Branch taken
    iaddrbusout[139] = 64'h00000000000002A0;
    
    daddrbusout[139] = dontcare;
    databusin[139] = activez;
    databusout[139] = dontcare;
    
    //NOP
    iaddrbusout[140] = 64'h00000000000002A4;
    
    instrbusin[140] = 32'b00000000000000000000000000000000;
    
    daddrbusout[140] = dontcare;
    databusin[140] = activez;
    databusout[140] = dontcare;
    
    //NOP
    iaddrbusout[141] = 64'h00000000000002C8;
    
    instrbusin[141] = 32'b00000000000000000000000000000000;
    
    daddrbusout[141] = dontcare;
    databusin[141] = activez;
    databusout[141] = dontcare;
    
    //SUBS X5, X20, X21
    iaddrbusout[142] = 64'h00000000000002CC;
    
    daddrbusout[142] = dontcare;
    databusin[142] = activez;
    databusout[142] = dontcare;
    
    //BNE #10           //Branch taken
    iaddrbusout[143] = 64'h00000000000002D0;
    
    daddrbusout[143] = dontcare;
    databusin[143] = activez;
    databusout[143] = dontcare;
    
    //NOP
    iaddrbusout[144] = 64'h00000000000002D4;
    
    instrbusin[144] = 32'b00000000000000000000000000000000;
    
    daddrbusout[144] = dontcare;
    databusin[144] = activez;
    databusout[144] = dontcare;
    
    //NOP
    iaddrbusout[145] = 64'h00000000000002F8;
    
    instrbusin[145] = 32'b00000000000000000000000000000000;
    
    daddrbusout[145] = dontcare;
    databusin[145] = activez;
    databusout[145] = dontcare;
    
    //NOP
    iaddrbusout[146] = 64'h00000000000002FC;
    
    instrbusin[146] = 32'b00000000000000000000000000000000;
    
    daddrbusout[146] = dontcare;
    databusin[146] = activez;
    databusout[146] = dontcare;
    
    //CBZ X15, #20      //Branch not taken
    iaddrbusout[147] = 64'h0000000000000300;
    
    daddrbusout[147] = dontcare;
    databusin[147] = activez;
    databusout[147] = dontcare;
        
    //NOP
    iaddrbusout[148] = 64'h0000000000000304;
    
    instrbusin[148] = 32'b00000000000000000000000000000000;
    
    daddrbusout[148] = dontcare;
    databusin[148] = activez;
    databusout[148] = dontcare;
    
    //CBZ X30, #0       //Branch not taken 
    iaddrbusout[149] = 64'h0000000000000308;
    
    daddrbusout[149] = dontcare;
    databusin[149] = activez;
    databusout[149] = dontcare;
    
    //NOP
    iaddrbusout[150] = 64'h000000000000030C;
    
    instrbusin[150] = 32'b00000000000000000000000000000000;
    
    daddrbusout[150] = dontcare;
    databusin[150] = activez;
    databusout[150] = dontcare;
    
    //CBNZ X20, #0      //Branch taken
    iaddrbusout[151] = 64'h0000000000000310;
    
    daddrbusout[151] = dontcare;
    databusin[151] = activez;
    databusout[151] = dontcare;
    
    //NOP
    iaddrbusout[152] = 64'h0000000000000314;
    
    instrbusin[152] = 32'b00000000000000000000000000000000;
    
    daddrbusout[152] = dontcare;
    databusin[152] = activez;
    databusout[152] = dontcare;
    
    //NOP
    iaddrbusout[153] = 64'h0000000000000310;
    
    instrbusin[153] = 32'b00000000000000000000000000000000;
    
    daddrbusout[153] = dontcare;
    databusin[153] = activez;
    databusout[153] = dontcare;
    
    //ADDIS X15, X18, #9A
    iaddrbusout[154] = 64'h0000000000000314;
    
    daddrbusout[154] = dontcare;
    databusin[154] = activez;
    databusout[154] = dontcare;
    
    //BEQ #80           //Branch not taken
    iaddrbusout[155] = 64'h0000000000000318;
    
    daddrbusout[155] = dontcare;
    databusin[155] = activez;
    databusout[155] = dontcare;
    
    //NOP
    iaddrbusout[156] = 64'h000000000000031C;
    
    instrbusin[156] = 32'b00000000000000000000000000000000;
    
    daddrbusout[156] = dontcare;
    databusin[156] = activez;
    databusout[156] = dontcare;
    
    //SUB X16, X6, X10
    iaddrbusout[157] = 64'h0000000000000320;
    
    daddrbusout[157] = dontcare;
    databusin[157] = activez;
    databusout[157] = dontcare;
    
    //ADDIS X19, X5, #8AC
    iaddrbusout[158] = 64'h0000000000000324;
    
    daddrbusout[158] = dontcare;
    databusin[158] = activez;
    databusout[158] = dontcare;
    
    //BLT #20           //Branch not taken
    iaddrbusout[159] = 64'h0000000000000328;
    
    daddrbusout[159] = dontcare;
    databusin[159] = activez;
    databusout[159] = dontcare;
    
    //NOP
    iaddrbusout[160] = 64'h000000000000032C;
    
    instrbusin[160] = 32'b00000000000000000000000000000000;
    
    daddrbusout[160] = dontcare;
    databusin[160] = activez;
    databusout[160] = dontcare;
    
    //ADDI X20, X8, #09E
    iaddrbusout[161] = 64'h0000000000000330;
    
    daddrbusout[161] = dontcare;
    databusin[161] = activez;
    databusout[161] = dontcare;
    
    //ADDIS X21, X12, #FEA
    iaddrbusout[162] = 64'h0000000000000334;
    
    daddrbusout[162] = dontcare;
    databusin[162] = activez;
    databusout[162] = dontcare;
    
    //CBZ X1, #10       //Branch taken
    iaddrbusout[163] = 64'h0000000000000338;
    
    daddrbusout[163] = dontcare;
    databusin[163] = activez;
    databusout[163] = dontcare;
    
    //NOP
    iaddrbusout[164] = 64'h000000000000033C;
    
    instrbusin[164] = 32'b00000000000000000000000000000000;
    
    daddrbusout[164] = dontcare;
    databusin[164] = activez;
    databusout[164] = dontcare;
    
    //NOP
    iaddrbusout[165] = 64'h0000000000000360;
    
    instrbusin[165] = 32'b00000000000000000000000000000000;
    
    daddrbusout[165] = dontcare;
    databusin[165] = activez;
    databusout[165] = dontcare;
    
    //B #0              //Branch taken
    iaddrbusout[166] = 64'h0000000000000364;
    
    daddrbusout[166] = dontcare;
    databusin[166] = activez;
    databusout[166] = dontcare;
    
    //NOP
    iaddrbusout[167] = 64'h0000000000000368;
    
    instrbusin[167] = 32'b00000000000000000000000000000000;
    
    daddrbusout[167] = dontcare;
    databusin[167] = activez;
    databusout[167] = dontcare;
    
    //CBNZ X1, #10      //Branch not taken
    iaddrbusout[168] = 64'h000000000000036C;
    
    daddrbusout[168] = dontcare;
    databusin[168] = activez;
    databusout[168] = dontcare;
    
    //NOP
    iaddrbusout[169] = 64'h0000000000000370;
    
    instrbusin[169] = 32'b00000000000000000000000000000000;
    
    daddrbusout[169] = dontcare;
    databusin[169] = activez;
    databusout[169] = dontcare;
    
    //ANDIS X22, X6, #ABC   
    iaddrbusout[170] = 64'h0000000000000374;
    
    daddrbusout[170] = dontcare;
    databusin[170] = activez;
    databusout[170] = dontcare;
    
    //BEQ #1            //Branch not taken
    iaddrbusout[171] = 64'h0000000000000378;
    
    daddrbusout[171] = dontcare;
    databusin[171] = activez;
    databusout[171] = dontcare;
    
    //NOP
    iaddrbusout[172] = 64'h000000000000037C;
    
    instrbusin[172] = 32'b00000000000000000000000000000000;
    
    daddrbusout[172] = dontcare;
    databusin[172] = activez;
    databusout[172] = dontcare;
    
    //ANDIS X23, X9, #765
    iaddrbusout[173] = 64'h0000000000000380;
    
    daddrbusout[173] = dontcare;
    databusin[173] = activez;
    databusout[173] = dontcare;
    
    //BNE #1        //Branch taken
    iaddrbusout[174] = 64'h0000000000000384;
    
    daddrbusout[174] = dontcare;
    databusin[174] = activez;
    databusout[174] = dontcare;
    
    //NOP
    iaddrbusout[175] = 64'h0000000000000388;
    
    instrbusin[175] = 32'b00000000000000000000000000000000;
    
    daddrbusout[175] = dontcare;
    databusin[175] = activez;
    databusout[175] = dontcare;
    
    //NOP
    iaddrbusout[176] = 64'h0000000000000388;
    
    instrbusin[176] = 32'b00000000000000000000000000000000;
    
    daddrbusout[176] = dontcare;
    databusin[176] = activez;
    databusout[176] = dontcare;
    
    //NOP
    iaddrbusout[177] = 64'h000000000000038C;
    
    instrbusin[177] = 32'b00000000000000000000000000000000;
    
    daddrbusout[177] = dontcare;
    databusin[177] = activez;
    databusout[177] = dontcare;
    
    //CBNZ X1, #12      //Branch not taken
    iaddrbusout[178] = 64'h0000000000000390;
    
    daddrbusout[178] = dontcare;
    databusin[178] = activez;
    databusout[178] = dontcare;
    
    //NOP
    iaddrbusout[179] = 64'h0000000000000394;
    
    instrbusin[179] = 32'b00000000000000000000000000000000;
    
    daddrbusout[179] = dontcare;
    databusin[179] = activez;
    databusout[179] = dontcare;
    
    //MOVZ  X23, #3A3
    iaddrbusout[180] = 64'h0000000000000398;
    
    daddrbusout[180] = dontcare;
    databusin[180] = activez;
    databusout[180] = dontcare;
    
    //CBZ   X16, #5     //Branch not taken
    iaddrbusout[181] = 64'h000000000000039C;
    
    daddrbusout[181] = dontcare;
    databusin[181] = activez;
    databusout[181] = dontcare;
    
    //NOP
    iaddrbusout[182] = 64'h00000000000003A0;
    
    instrbusin[182] = 32'b00000000000000000000000000000000;
    
    daddrbusout[182] = dontcare;
    databusin[182] = activez;
    databusout[182] = dontcare;
    
    //MOVZ  X24, #0
    iaddrbusout[183] = 64'h00000000000003A4;
    
    daddrbusout[183] = dontcare;
    databusin[183] = activez;
    databusout[183] = dontcare;
    
    //SUBIS X25, X13, #AAA
    iaddrbusout[184] = 64'h00000000000003A8;
    
    daddrbusout[184] = dontcare;
    databusin[184] = activez;
    databusout[184] = dontcare;
    
    //CBNZ  X1, #9      //Branch not taken
    iaddrbusout[185] = 64'h00000000000003AC;
    
    daddrbusout[185] = dontcare;
    databusin[185] = activez;
    databusout[185] = dontcare;
    
    //NOP
    iaddrbusout[186] = 64'h00000000000003B0;
    
    instrbusin[186] = 32'b00000000000000000000000000000000;
    
    daddrbusout[186] = dontcare;
    databusin[186] = activez;
    databusout[186] = dontcare;
    
    //SUBIS X26, X8, #0
    iaddrbusout[187] = 64'h00000000000003B4;
    
    daddrbusout[187] = dontcare;
    databusin[187] = activez;
    databusout[187] = dontcare;
    
    //SUBIS X27, X3, #EFE
    iaddrbusout[188] = 64'h00000000000003B8;
    
    daddrbusout[188] = dontcare;
    databusin[188] = activez;
    databusout[188] = dontcare;
    
    //BNE #14           //Branch taken
    iaddrbusout[189] = 64'h00000000000003BC;
    
    daddrbusout[189] = dontcare;
    databusin[189] = activez;
    databusout[189] = dontcare;
    
    //NOP
    iaddrbusout[190] = 64'h00000000000003C0;
    
    instrbusin[190] = 32'b00000000000000000000000000000000;
    
    daddrbusout[190] = dontcare;
    databusin[190] = activez;
    databusout[190] = dontcare;
    
    //NOP
    iaddrbusout[191] = 64'h00000000000003F4;
    
    instrbusin[191] = 32'b00000000000000000000000000000000;
    
    daddrbusout[191] = dontcare;
    databusin[191] = activez;
    databusout[191] = dontcare;
    
    //NOP
    iaddrbusout[192] = 64'h00000000000003F8;
    
    instrbusin[192] = 32'b00000000000000000000000000000000;
    
    daddrbusout[192] = dontcare;
    databusin[192] = activez;
    databusout[192] = dontcare;
    
    //MOVZ X28, #9AE
    iaddrbusout[193] = 64'h00000000000003FC;
    
    daddrbusout[193] = dontcare;
    databusin[193] = activez;
    databusout[193] = dontcare;
    
    //ADD X29, X0, X1
    iaddrbusout[194] = 64'h0000000000000400;
    
    daddrbusout[194] = dontcare;
    databusin[194] = activez;
    databusout[194] = dontcare;
    
    //AND X30, X3, X2
    iaddrbusout[195] = 64'h0000000000000404;
    
    daddrbusout[195] = dontcare;
    databusin[195] = activez;
    databusout[195] = dontcare;
    
    //SUB X5, X2, X7
    iaddrbusout[196] = 64'h0000000000000408;
    
    daddrbusout[196] = dontcare;
    databusin[196] = activez;
    databusout[196] = dontcare;
    
    //ORR X0, X10, X11
    iaddrbusout[197] = 64'h000000000000040C;
    
    daddrbusout[197] = dontcare;
    databusin[197] = activez;
    databusout[197] = dontcare;
    
    //ANDI X1, X1, X4
    iaddrbusout[198] = 64'h0000000000000410;
    
    daddrbusout[198] = dontcare;
    databusin[198] = activez;
    databusout[198] = dontcare;
    
    //ADDI X2, X20, #90A
    iaddrbusout[199] = 64'h0000000000000414;
    
    daddrbusout[199] = dontcare;
    databusin[199] = activez;
    databusout[199] = dontcare;
    
    //SUBI X4, X3, #AFF
    iaddrbusout[200] = 64'h0000000000000418;
    
    daddrbusout[200] = dontcare;
    databusin[200] = activez;
    databusout[200] = dontcare;
    
    //ORRI X6, X8, #00A
    iaddrbusout[201] = 64'h000000000000041C;
    
    daddrbusout[201] = dontcare;
    databusin[201] = activez;
    databusout[201] = dontcare;
    
    //EOR X7, X17, X18
    iaddrbusout[202] = 64'h0000000000000420;
    
    daddrbusout[202] = dontcare;
    databusin[202] = activez;
    databusout[202] = dontcare;
    
    //EORI X8, X22, #00C
    iaddrbusout[203] = 64'h0000000000000424;
    
    daddrbusout[203] = dontcare;
    databusin[203] = activez;
    databusout[203] = dontcare;
    
    //ADD X9, X27, X28
    iaddrbusout[204] = 64'h0000000000000428;
    
    daddrbusout[204] = dontcare;
    databusin[204] = activez;
    databusout[204] = dontcare;
    
    //SUB X10, X27, X25
    iaddrbusout[205] = 64'h000000000000042C;
    
    daddrbusout[205] = dontcare;
    databusin[205] = activez;
    databusout[205] = dontcare;
    
    //AND X11, X20, X21
    iaddrbusout[206] = 64'h0000000000000430;
    
    daddrbusout[206] = dontcare;
    databusin[206] = activez;
    databusout[206] = dontcare;
    
    //EOR X12, X26, X15
    iaddrbusout[207] = 64'h0000000000000434;
    
    daddrbusout[207] = dontcare;
    databusin[207] = activez;
    databusout[207] = dontcare;
    
    //ORR X13, X2, X16
    iaddrbusout[208] = 64'h0000000000000438;
    
    daddrbusout[208] = dontcare;
    databusin[208] = activez;
    databusout[208] = dontcare;
    
    //ADDI X14, X28, #E45
    iaddrbusout[209] = 64'h000000000000043C;
    
    daddrbusout[209] = dontcare;
    databusin[209] = activez;
    databusout[209] = dontcare;
    
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
    
    for (k=0; k<= 111; k=k+1) begin
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
